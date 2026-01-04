//
//  UIColor+HexString.swift
//  iRings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import UIKit

public extension UIColor {
	convenience init(hexString: String) {
		let hexSanitized = hexString
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.replacingOccurrences(of: "#", with: "")
			.lowercased()

		var rgb: UInt64 = 0

		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		let a: CGFloat = 1.0

		let length = hexSanitized.count

		guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
			self.init()
			return
		}

		if length == 6 {
			r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
			g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
			b = CGFloat(rgb & 0x0000FF) / 255.0
		} else {
			self.init()
		}

		self.init(red: r, green: g, blue: b, alpha: a)
	}
}
