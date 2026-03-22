//
//  DataMigrationManager.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 22.03.2026.
//  Copyright © 2026 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public protocol DataMigrationManaging {
	func exportData() throws -> Data
	func importData(from data: Data) throws -> ImportResult
}

public struct ImportResult {
	public let ringsCount: Int
	public let ringLogsCount: Int
}

public enum DataMigrationError: Error {
	case unsupportedVersion(Int)
}

final class DataMigrationManager: DataMigrationManaging {
	
	private let coreDataManager: CoreDataManaging
	
	// MARK: - Init
	
	init(coreDataManager: CoreDataManaging) {
		self.coreDataManager = coreDataManager
	}
	
	// MARK: - Public API
	
	func exportData() throws -> Data {
		let rings: [Ring] = try coreDataManager.loadAll()
		let ringLogs: [RingLog] = try coreDataManager.loadAll()
		
		let envelope = ExportEnvelope(
			appVersion: Bundle.main.version,
			rings: rings,
			ringLogs: ringLogs
		)
		
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
		return try encoder.encode(envelope)
	}
	
	func importData(from data: Data) throws -> ImportResult {
		let envelope = try JSONDecoder().decode(ExportEnvelope.self, from: data)
		
		guard envelope.version <= ExportEnvelope.currentVersion else {
			throw DataMigrationError.unsupportedVersion(envelope.version)
		}
		
		for ring in envelope.rings {
			try coreDataManager.save(item: ring)
		}
		
		for ringLog in envelope.ringLogs {
			try coreDataManager.save(item: ringLog)
		}
		
		return ImportResult(
			ringsCount: envelope.rings.count,
			ringLogsCount: envelope.ringLogs.count
		)
	}
}
