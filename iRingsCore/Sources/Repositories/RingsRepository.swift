//
//  RingsRepository.swift
//  Ring
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import Combine

public protocol RingsRepositoring {
	func rings() -> AnyPublisher<[Ring], Error>
	func ringLogs(ids: [RingLog.ID]) -> AnyPublisher<[RingLog], Error>
	
	func ring(id: Ring.ID) -> AnyPublisher<Ring, Error>
	func ringLog(id: RingLog.ID) -> AnyPublisher<RingLog, Error>
	
	func save(ring: Ring) throws
	
	func addLog(for ring: Ring, date: Date?, completionRatio: CGFloat, note: String?) throws
	func editLog(log: RingLog, date: Date, completionRatio: CGFloat, note: String?) throws
	
	func deleteRing(id: Ring.ID, logIds: [RingLog.ID]) throws
	func deleteLog(for ring: Ring, logId: RingLog.ID) throws
}

public extension RingsRepositoring {
	func addLog(
		for ring: Ring,
		date: Date? = nil,
		completionRatio: CGFloat = 1,
		note: String? = nil
	) throws {
		try addLog(
			for: ring,
			date: date,
			completionRatio: completionRatio,
			note: note
		)
	}
	
	func editLog(
		log: RingLog,
		date: Date,
		completionRatio: CGFloat = 1,
		note: String? = nil
	) throws {
		try editLog(
			log: log,
			date: date,
			completionRatio: completionRatio,
			note: note
		)
	}
}

final class RingsRepository: BaseRepository, RingsRepositoring {
	
	private var ringsSubject = PassthroughSubject<[Ring], Error>()
	private var ringLogsSubject = PassthroughSubject<[RingLog], Error>()
	
	private var ringSubject = PassthroughSubject<Ring, Error>()
	private var ringLogSubject = PassthroughSubject<RingLog, Error>()
	
	// MARK: - Init
	
	override init(coreDataManager: CoreDataManaging) {
		super.init(coreDataManager: coreDataManager)
	}
	
	// MARK: - Public API
	
	func rings() -> AnyPublisher<[Ring], Error> {
		ringsSubject.onReceiveSubscription { _ in
			DispatchQueue.global().async {
				self.loadItems(subject: self.ringsSubject)
			}
		}
	}
	
	func ringLogs(ids: [RingLog.ID]) -> AnyPublisher<[RingLog], Error> {
		ringLogsSubject.onReceiveSubscription { _ in
			DispatchQueue.global().async {
				self.loadItems(ids: ids, subject: self.ringLogsSubject)
			}
		}
	}
	
	func ring(id: Ring.ID) -> AnyPublisher<Ring, Error> {
		ringSubject.onReceiveSubscription { _ in
			DispatchQueue.global().async {
				self.loadItem(id: id, subject: self.ringSubject)
			}
		}
	}
	
	func ringLog(id: RingLog.ID) -> AnyPublisher<RingLog, Error> {
		ringLogSubject.onReceiveSubscription { _ in
			DispatchQueue.global().async {
				self.loadItem(id: id, subject: self.ringLogSubject)
			}
		}
	}
	
	func save(ring: Ring) throws {
		try saveItem(item: ring)
		
		// Refresh rings
		loadItems(subject: ringsSubject)
		loadItem(id: ring.id, subject: ringSubject)
	}
	
	func addLog(for ring: Ring, date: Date?, completionRatio: CGFloat, note: String?) throws {
		var ring = ring
		
		let newLog = ring.newLog(
			date: date,
			completionRatio: completionRatio,
			note: note
		)
		
		try saveItem(item: newLog)
		try saveItem(item: ring)
		
		// Refresh rings
		loadItems(subject: ringsSubject)
		loadItem(id: ring.id, subject: ringSubject)
	}
	
	func editLog(log: RingLog, date: Date, completionRatio: CGFloat, note: String?) throws {
		let editedLog = RingLog(
			id: log.id,
			date: date,
			completionRatio: completionRatio,
			note: note,
			createdAt: log.createdAt,
			updatedAt: .now
		)
		try saveItem(item: editedLog)
	}
	
	func save(ringLog: RingLog) throws {
		try saveItem(item: ringLog)
	}
	
	func deleteRing(id: Ring.ID, logIds: [RingLog.ID]) throws {
		try deleteItem(id: id, entityType: Ring.entityType)
		
		if logIds.isNotEmpty {
			try deleteItems(ids: logIds, entityType: RingLog.entityType)
		}
		
		// Refresh rings
		loadItems(subject: ringsSubject)
	}
	
	func deleteLog(for ring: Ring, logId: RingLog.ID) throws {
		let updatedLogIds = ring.logIds.filter { $0 != logId }
		let updatedRing = Ring(
			id: ring.id,
			name: ring.name,
			targetCount: ring.targetCount,
			startDate: ring.startDate,
			endDate: ring.endDate,
			lastUpdate: ring.lastUpdate,
			logIds: updatedLogIds
		)
		
		try deleteItem(id: logId, entityType: RingLog.entityType)
		try saveItem(item: updatedRing)
		
		// Refresh rings
		loadItems(subject: ringsSubject)
		loadItem(id: ring.id, subject: ringSubject)
	}
}
