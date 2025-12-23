//
//  ActivityMock.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public extension Activity {
	static var mock1: Activity {
		mock(
			id: "1",
			title: "Gym",
			targetCount: 10,
			category: .fitness,
			logIds: [ "1", "2", "3", "4", "5", "6", "7", "8" ]
		)
	}
	
	static var mock2: Activity {
		mock(
			id: "2",
			title: "Read books",
			targetCount: 5,
			category: .reading,
			logIds: [ "1", "2" ]
		)
	}
	
	static var mock3: Activity {
		mock(
			id: "3",
			title: "Save money",
			targetCount: 10,
			category: .finance,
			logIds: [ "1", "2", "3", "4", "5" ]
		)
	}
}

public extension [Activity] {
	static var mock: [Activity] {
		[
			.mock1,
			.mock2,
			.mock3
		]
	}
}

fileprivate extension Activity {
	static func mock(
		id: String,
		title: String,
		targetCount: Int,
		startDate: Date = .mock2024,
		endDate: Date = .mock2026,
		category: Category,
		logIds: [ActivityLog.ID] = []
	) -> Activity {
		.init(
			id: id,
			title: title,
			targetCount: targetCount,
			startDate: startDate,
			endDate: endDate,
			category: category,
			logIds: logIds
		)
	}
}
