//
//  VertexMock.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 28.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public extension [Vertex] {
	static var mock: [Vertex] {
		[
			.init(date: .date(from: "2026-01-01 00:00:00 +0000")!, value: 100.00),
			.init(date: .date(from: "2026-01-02 19:55:00 +0000")!, value: 185.56),
			.init(date: .date(from: "2026-01-04 11:03:00 +0000")!, value: 335.83),
			.init(date: .date(from: "2026-01-06 08:03:00 +0000")!, value: 234.79),
			.init(date: .date(from: "2026-01-07 12:02:00 +0000")!, value: 273.11),
			.init(date: .date(from: "2026-01-09 10:01:00 +0000")!, value: 167.57),
			.init(date: .date(from: "2026-01-10 00:00:00 +0000")!, value: 251.26)
		].sorted()
	}
}

private extension Date {
	static func date(from string: String) -> Date? {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
		return formatter.date(from: string)
	}
}
