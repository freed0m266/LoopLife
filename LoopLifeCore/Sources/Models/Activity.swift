//
//  Activity.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public struct Activity: Storable {
	public let id: String
	public var title: String
	public var targetCount: Int
	public var startDate: Date
	public var endDate: Date
	public var category: Category
	public var logIds: [ActivityLog.ID]
}

extension Activity {
	public enum Category: String, Codable {
		case fitness
		case reading
		case finance
		case habit
		case custom
	}
}

public extension Activity {
	var completedCount: Int {
		logIds.count
	}
	
	var daysElapsed: Int {
		Calendar.current.dateComponents([.day], from: startDate, to: .now).day ?? 0
	}
	
	var daysTotal: Int {
		Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 1
	}
	
	var progressRatio: Double {
		Double(completedCount) / Double(targetCount)
	}
	
	var timeRatio: Double {
		Double(daysElapsed) / Double(daysTotal)
	}
}
