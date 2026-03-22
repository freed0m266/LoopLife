//
//  ExportEnvelope.swift
//  TempooCore
//
//  Created by Martin Svoboda on 22.03.2026.
//  Copyright © 2026 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public struct ExportEnvelope: Codable {
	public static let currentVersion = 1
	
	public let version: Int
	public let exportedAt: Date
	public let appVersion: String?
	public let rings: [Ring]
	public let ringLogs: [RingLog]
	
	public init(
		version: Int = Self.currentVersion,
		exportedAt: Date = .now,
		appVersion: String? = nil,
		rings: [Ring],
		ringLogs: [RingLog]
	) {
		self.version = version
		self.exportedAt = exportedAt
		self.appVersion = appVersion
		self.rings = rings
		self.ringLogs = ringLogs
	}
}
