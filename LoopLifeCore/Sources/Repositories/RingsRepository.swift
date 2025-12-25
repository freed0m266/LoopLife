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
	func ringLogs(ids: [RingLog]) -> AnyPublisher<[RingLog], Error>
	
	func ring(id: Ring.ID) -> AnyPublisher<Ring, Error>
	func ringLog(id: RingLog.ID) -> AnyPublisher<RingLog, Error>
	
	func save(ring: Ring) throws
	
	func recordLog(for ring: Ring, date: Date?, completionRatio: CGFloat, note: String?) throws
	
	func deleteRing(id: Ring.ID) throws
	func deleteRingLog(id: RingLog.ID) throws
}

public extension RingsRepositoring {
	func recordLog(
		for ring: Ring,
		date: Date? = nil,
		completionRatio: CGFloat = 1,
		note: String? = nil
	) throws {
		try recordLog(
			for: ring,
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
		ringsSubject.onReceiveSubscription { [unowned self] _ in
			loadItems(subject: ringsSubject)
		}
	}
	
	func ringLogs(ids: [RingLog]) -> AnyPublisher<[RingLog], Error> {
		ringLogsSubject.onReceiveSubscription { [unowned self] _ in
			loadItems(subject: ringLogsSubject)
		}
	}
	
	func ring(id: Ring.ID) -> AnyPublisher<Ring, Error> {
		ringSubject.onReceiveSubscription { [unowned self] _ in
			loadItem(id: id, subject: ringSubject)
		}
	}
	
	func ringLog(id: RingLog.ID) -> AnyPublisher<RingLog, Error> {
		ringLogSubject.onReceiveSubscription { [unowned self] _ in
			loadItem(id: id, subject: ringLogSubject)
		}
	}
	
	func save(ring: Ring) throws {
		try saveItem(item: ring)
	}
	
	func recordLog(for ring: Ring, date: Date?, completionRatio: CGFloat, note: String?) throws {
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
	}
	
	func save(ringLog: RingLog) throws {
		try saveItem(item: ringLog)
	}
	
	func deleteRing(id: Ring.ID) throws {
		try deleteItem(id: id, entityType: Ring.entityType)
	}
	
	func deleteRingLog(id: RingLog.ID) throws {
		try deleteItem(id: id, entityType: RingLog.entityType)
	}
}
