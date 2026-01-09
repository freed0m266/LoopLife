//
//  Date+Extensions.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public extension Date {
	func plus(minutes: Int) -> Date {
		// swiftlint:disable:next force_unwrapping
		Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
	}
	
	func plus(hours: Int) -> Date {
		// swiftlint:disable:next force_unwrapping
		Calendar.current.date(byAdding: .hour, value: hours, to: self)!
	}
	
	func plus(days: Int) -> Date {
		// swiftlint:disable:next force_unwrapping
		Calendar.current.date(byAdding: .day, value: days, to: self)!
	}
	
	func plus(months: Int) -> Date {
		// swiftlint:disable:next force_unwrapping
		Calendar.current.date(byAdding: .month, value: months, to: self)!
	}
	
	func plus(years: Int) -> Date {
		// swiftlint:disable:next force_unwrapping
		Calendar.current.date(byAdding: .year, value: years, to: self)!
	}
}

public extension Date {
	var startOfYear: Date {
		Calendar.current.date(from: Calendar.current.dateComponents([.year], from: self)) ?? self
	}
	
	var startOfMonth: Date {
		Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)) ?? self
	}
	
	var startOfDay: Date {
		Calendar.current.startOfDay(for: self)
	}
	
	var isToday: Bool {
		Calendar.current.isDateInToday(self)
	}
	
	var isYesterday: Bool {
		Calendar.current.isDateInYesterday(self)
	}
	
	func daysElapsed(until other: Date = .now) -> Int {
		Calendar.current.dateComponents([.day], from: startOfDay, to: other.startOfDay).day ?? 0
	}
	
	func daysRemaining(from other: Date = .now) -> Int {
		Calendar.current.dateComponents([.day], from: other.startOfDay, to: startOfDay).day ?? 0
	}
}

public extension Date {
	/// H:mm
	var hourMinuteFormat: String {
		hourMinuteDateFormatter.string(from: self)
	}
	
	/// d. M.
	var dayMonthFormat: String {
		dayMonthDateFormatter.string(from: self)
	}
	
	/// d. M. yyyy
	var dayMonthYearFormat: String {
		dayMonthYearDateFormatter.string(from: self)
	}
	
	/// EEEE d. M.
	var dayWeekMonthFormat: String {
		dayWeekMonthDateFormatter.string(from: self)
	}
	
	/// d. M. yyyy • H:mm
	var dayMonthYearHourMinuteFormat: String {
		dayMonthYearFormat + " • " + hourMinuteFormat
	}
}

public extension Date {
	static var placeholder: Date {
		fromComponents(year: 2000, month: 1, day: 1)
	}
}

private var hourMinuteDateFormatter: DateFormatter = {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "H:mm"
	return dateFormatter
}()

private var dayMonthDateFormatter: DateFormatter = {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "d. M."
	return dateFormatter
}()

private var dayMonthYearDateFormatter: DateFormatter = {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "d. M. yyyy"
	return dateFormatter
}()

private var dayWeekMonthDateFormatter: DateFormatter = {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "EEEE d. M."
	return dateFormatter
}()
