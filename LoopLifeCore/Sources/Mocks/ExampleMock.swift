//
//  ExampleMock.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public extension Example {
	static var mock1: Example {
		.mock(
			id: "1"
		)
	}
	
	static var mock2: Example {
		.mock(
			id: "2",
			text: "Random text"
		)
	}
	
	static var mock3: Example {
		.mock(
			id: "3",
			text: "Another random text"
		)
	}
}

public extension [Example] {
	static var mock: [Example] {
		[
			.mock1,
			.mock2,
			.mock3
		]
	}
}

fileprivate extension Example {
	static func mock(
		id: String,
		text: String = "Hello, World!"
	) -> Example {
		.init(
			id: id,
			text: text
		)
	}
}
