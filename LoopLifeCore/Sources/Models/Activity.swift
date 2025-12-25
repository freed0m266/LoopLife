//
//  Activity.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import LoopLifeResources

public struct Activity: Storable {
	public let id: String
	public var name: String
	public var targetCount: Int
	public var startDate: Date
	public var endDate: Date
	public var lastUpdate: Date
	public var logIds: [ActivityLog.ID]
	
	public init(
		id: String = UUID().uuidString,
		name: String,
		targetCount: Int,
		startDate: Date,
		endDate: Date,
		lastUpdate: Date = .now,
		logIds: [ActivityLog.ID] = []
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
	) -> ActivityLog {
		let id = "\(id).\(UUID().uuidString)"
		let createdAt = Date()
		let date = date ?? createdAt
		
		let newLog = ActivityLog(
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

public extension Activity {
	var completedCount: Int {
		logIds.count
	}
	
	var daysElapsed: Int {
		startDate.daysElapsed
	}
	
	var daysRemaining: Int {
		endDate.daysRemaining
	}
	
	var daysTotal: Int {
		Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 1
	}
	
	var progressRatioText: String {
		"\(completedCount)/\(targetCount)"
	}
	
	var progressRatio: Double {
		Double(completedCount) / Double(targetCount)
	}
	
	var timeRatio: Double {
		Double(daysElapsed) / Double(daysTotal)
	}
}
