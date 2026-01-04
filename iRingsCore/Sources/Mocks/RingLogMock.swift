//
//  RingLogMock.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 12.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public extension RingLog {
	static var mock1: RingLog {
		.mock(
			id: "1",
			date: .mock2021
		)
	}
	
	static var mock2: RingLog {
		.mock(
			id: "2",
			date: .mock2022
		)
	}
	
	static var mock3: RingLog {
		.mock(
			id: "3",
			date: .mock2023
		)
	}
	
	static var mock4: RingLog {
		.mock(
			id: "4",
			date: .mock2024
		)
	}
}

public extension [RingLog] {
	static var mock: [RingLog] {
		[
			.mock1,
			.mock2,
			.mock3,
			.mock4
		]
	}
}

fileprivate extension RingLog {
	static func mock(
		id: String,
		date: Date,
		completionRatio: CGFloat = 1.0,
		note: String? = "note",
		createdAt: Date = .now,
		updatedAt: Date? = nil
	) -> RingLog {
		.init(
			id: id,
			date: date,
			completionRatio: completionRatio,
			note: note,
			createdAt: createdAt,
			updatedAt: updatedAt
		)
	}
}
