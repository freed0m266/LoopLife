//
//  FormattableNumber.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 25.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore

public protocol FormattableNumber: Equatable {
	init?(localizedText: String)
}

extension FormattableNumber {
	static func nsNumber(from localizedText: String) -> NSNumber? {
		let cleanedText = localizedText.withoutSpaces
			.replacingOccurrences(of: NumberFormatter.decimal.groupingSeparator ?? "", with: "")
		
		return NumberFormatter.decimal.number(from: cleanedText)
	}
	
	public func formatted(maxPrecision: Int?) -> String {
		let formatter: NumberFormatter
		
		if let maxPrecision {
			let copy = NumberFormatter.decimal.copy() as? NumberFormatter
			copy?.maximumFractionDigits = maxPrecision
			formatter = copy ?? NumberFormatter.decimal
		} else {
			formatter = NumberFormatter.decimal
		}
		
		return formatter.string(for: self) ?? String(describing: self)
	}
}

extension Int: FormattableNumber {
	public init?(localizedText: String) {
		guard let number = Int.nsNumber(from: localizedText) else { return nil }
		self = number.intValue
	}
}

extension Double: FormattableNumber {
	public init?(localizedText: String) {
		guard let number = Double.nsNumber(from: localizedText) else { return nil }
		self = number.doubleValue
	}
}
