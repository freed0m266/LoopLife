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
			targetCount: 100,
			category: .fitness
		)
	}
	
	static var mock2: Activity {
		mock(
			id: "2",
			title: "Read books",
			targetCount: 24,
			category: .reading
		)
	}
	
	static var mock3: Activity {
		mock(
			id: "3",
			title: "Save money",
			targetCount: 1_000_000,
			category: .finance
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
		startDate: Date = .mock2000,
		endDate: Date = .mock2077,
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
