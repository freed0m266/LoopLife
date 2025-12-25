//
//  RingMock.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public extension Ring {
	static var mock1: Ring {
		mock(
			id: "1",
			name: "Fitness",
			targetCount: 10,
			logIds: [ "1", "2", "3", "4", "5", "6", "7" ]
		)
	}
	
	static var mock2: Ring {
		mock(
			id: "2",
			name: "Reading",
			targetCount: 5,
			logIds: [ "1", "2" ]
		)
	}
	
	static var mock3: Ring {
		mock(
			id: "3",
			name: "Finance",
			targetCount: 10,
			logIds: [ "1", "2", "3", "4", "5" ]
		)
	}
}

public extension [Ring] {
	static var mock: [Ring] {
		[
			.mock1,
			.mock2,
			.mock3
		]
	}
}

fileprivate extension Ring {
	static func mock(
		id: String,
		name: String,
		targetCount: Int,
		startDate: Date = .mock2024,
		endDate: Date = .mock2026,
		lastUpdate: Date = .mock2024,
		logIds: [RingLog.ID] = []
	) -> Ring {
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
