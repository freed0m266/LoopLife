//
//  Example.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public struct Example: Identifiable {
	public let id: String
	public let text: String
}

extension Example {
	public static var empty: Example {
		.init(id: "", text: "")
	}
}
