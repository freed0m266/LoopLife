//
//  String+Extensions.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 25.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public extension String {
	var withoutSpaces: String {
		replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
	}
}
