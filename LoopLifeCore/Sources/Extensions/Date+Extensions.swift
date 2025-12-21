//
//  Date+Extensions.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public extension Date {
	/// EEEE d. M.
	var dayWeekMonthFormat: String {
		dayMonthYearDateFormatter.string(from: self)
	}
}

private var dayMonthYearDateFormatter: DateFormatter = {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "EEEE d. M."
	return dateFormatter
}()
