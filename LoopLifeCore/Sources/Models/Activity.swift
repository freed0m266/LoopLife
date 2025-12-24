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
	public var title: String
	public var targetCount: Int
	public var startDate: Date
	public var endDate: Date
	public var category: Category
	public var logIds: [ActivityLog.ID]
	
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
		return newLog
	}
}

extension Activity {
	public enum Category: String, Identifiable, Codable, CaseIterable {
		case fitness
		case reading
		case finance
		case addiction
		case habit
		
		public var id: Category {
			self
		}
		
		public var name: String {
			switch self {
			case .fitness: L10n.Category.fitness
			case .reading: L10n.Category.reading
			case .finance: L10n.Category.finance
			case .addiction: L10n.Category.addiction
			case .habit: L10n.Category.habit
			}
		}
	}
}

public extension Activity {
	var completedCount: Int {
		logIds.count
	}
	
	var daysElapsed: Int {
		Calendar.current.dateComponents([.day], from: startDate, to: .now).day ?? 0
	}
	
	var daysRemaining: Int {
		Calendar.current.dateComponents([.day], from: .now, to: endDate).day ?? 0
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
