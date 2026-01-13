//
//  Date+Extensions.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public extension Date {
	func days(from startDate: Date) -> CGFloat {
		let calendar: Calendar = .current
		let dayIndex = calendar.dateComponents([.day], from: startDate, to: startOfDay).day ?? 0
		let secondsInDay: CGFloat = 24 * 60 * 60
		
		let secondsSinceStartOfDay =
		CGFloat(calendar.component(.hour, from: self)) * 3600 +
		CGFloat(calendar.component(.minute, from: self)) * 60 +
		CGFloat(calendar.component(.second, from: self))
		
		return CGFloat(dayIndex) + secondsSinceStartOfDay / secondsInDay
	}
}

public extension Date {
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
