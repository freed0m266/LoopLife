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
			name: "Fitness",
			targetCount: 10,
			logIds: [ "1", "2", "3", "4", "5", "6", "7" ]
		)
	}
	
	static var mock2: Activity {
		mock(
			id: "2",
			name: "Reading",
			targetCount: 5,
			logIds: [ "1", "2" ]
		)
	}
	
	static var mock3: Activity {
		mock(
			id: "3",
			name: "Finance",
			targetCount: 10,
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
		name: String,
		targetCount: Int,
		startDate: Date = .mock2024,
		endDate: Date = .mock2026,
		lastUpdate: Date = .mock2024,
		logIds: [ActivityLog.ID] = []
	) -> Activity {
		.init(
			id: id,
			name: name,
			targetCount: targetCount,
			startDate: startDate,
			endDate: endDate,
			lastUpdate: lastUpdate,
			logIds: logIds
		)
	}
}
