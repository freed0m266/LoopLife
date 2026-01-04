//
//  NumberFormatter+Extensions.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 25.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public extension NumberFormatter {
	static let decimal = {
		let formatter = NumberFormatter()
		formatter.locale = .autoupdatingCurrent
		formatter.numberStyle = .decimal
		return formatter
	}()
}
