//
//  Vertex.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 28.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public struct Vertex: Hashable, Identifiable {
	public let date: Date
	public let value: Double
	
	public var id: Self { self }
	
	public init(date: Date, value: Double) {
		self.date = date
		self.value = value
	}
}

extension Vertex: Comparable {
	public static func < (lhs: Vertex, rhs: Vertex) -> Bool {
		lhs.date < rhs.date
	}
}
