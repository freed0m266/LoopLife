//
//  Ring.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsResources

public struct Ring: Storable {
	public let id: String
	public var name: String
	public var targetCount: Int
	public var startDate: Date
	public var endDate: Date
	public var lastUpdate: Date?
	public var logIds: [RingLog.ID]
	
	public init(
		id: String = UUID().uuidString,
		name: String,
		targetCount: Int,
		startDate: Date = .now.startOfDay,
		endDate: Date,
		lastUpdate: Date? = nil,
		logIds: [RingLog.ID] = []
	) {
		self.id = id
		self.name = name
		self.targetCount = targetCount
		self.startDate = startDate
		self.endDate = endDate
		self.lastUpdate = lastUpdate
		self.logIds = logIds
	}
	public mutating func newLog(
		date: Date? = nil,
		completionRatio: CGFloat = 1,
		note: String? = nil
	) -> RingLog {
		let id = "\(id).\(UUID().uuidString)"
		let createdAt = Date()
		let date = date ?? createdAt
		
		let newLog = RingLog(
			id: id,
			date: date,
			completionRatio: completionRatio,
			note: note,
			createdAt: createdAt
		)
		
		logIds.append(newLog.id)
		lastUpdate = .now
		return newLog
	}
}

public extension Ring {
	var completedCount: Int {
		logIds.count
	}
	
	var daysElapsed: Int {
		startDate.daysElapsed()
	}
	
	var daysRemaining: Int {
		endDate.daysRemaining()
	}
	
	var daysTotal: Int {
		Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 1
	}
	
	var progressRatioText: String {
		"\(completedCount)/\(targetCount)"
	}
	
	var paceIndexText: String {
		"\(CGFloat(progressRatio / timeRatio * 100).formatted(maxPrecision: 0)) %"
	}
	
	var progressRatio: Double {
		Double(completedCount) / Double(targetCount)
	}
	
	var timeRatio: Double {
		Double(daysElapsed) / Double(daysTotal)
	}
}
