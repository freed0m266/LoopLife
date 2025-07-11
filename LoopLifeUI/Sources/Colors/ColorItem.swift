//
//  ColorItem.swift
//  LoopLife
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct ColorItem {
	private let hex: String
	private let alpha: Double
	
	init(hex: String, alpha: Double = 1) {
		self.hex = hex
		self.alpha = alpha
	}
	
	public var uiColor: UIColor {
		UIColor(hexString: hex).withAlphaComponent(alpha)
	}
	
	public var color: Color {
		Color(hexString: hex).opacity(alpha)
	}
	
	public func opacity(_ opacity: Double) -> ColorItem {
		.init(hex: hex, alpha: opacity)
	}
}

extension ColorItem: ExpressibleByStringLiteral {
	public init(stringLiteral value: StaticString) {
		self.hex = "\(value)"
		self.alpha = 1
	}
}

public extension ColorItem {
	
	// MARK: - Foreground

	/// #26334D
	static var foregroundPrimary: ColorItem = "26334D"
	/// #666A80
	static var foregroundSecondary: ColorItem = "666A80"
	/// #99A6B5
	static var foregroundDisabled: ColorItem = "99A6B5"
	/// #FFFFFF
	static var foregroundOnPrimary: ColorItem = "FFFFFF"
	
	// MARK: - Icons
	
	/// #A3A8BF
	static var iconPrimary: ColorItem = "A3A8BF"
	
	// MARK: - Background
	
	/// #F2F4F7
	static var backgroundPrimary: ColorItem = "F2F4F7"
	/// #FFFFFF
	static var backgroundSecondary: ColorItem = "FFFFFF"
	/// #FFFFFF
	static var backgroundDisabled: ColorItem = "445161"
	
	// MARK: - Basic
	
	/// #FFFFFF
	static var basicWhite: ColorItem = "FFFFFF"
	/// #000000
	static var basicBlack: ColorItem = "000000"
	/// #F50A8F
	static var basicMagenta: ColorItem = "F50A8F"
	/// #1878F5
	static var basicBlue: ColorItem = "1878F5"
	/// #006ЕВ6
	static var darkBlue: ColorItem = "006EB6"
	/// #F50A0A
	static var basicRed: ColorItem = "F50A0A"
	/// #C0780C
	static var basicOrange: ColorItem = "C0780C"
	/// #2F9842
	static var basicGreen: ColorItem = "2F9842"
	
	// MARK: - Pastel
	
	/// #FFE5F6
	static var pastelMagenta: ColorItem = "FFE5F6"
	/// #DBEAFF
	static var pastelBlue: ColorItem = "DBEAFF"
	/// #E6EAF0
	static var pastelGray: ColorItem = "E6EAF0"
	/// #FFE5E5
	static var pastelRed: ColorItem = "FFE5E5"
	/// #FFF5E5
	static var pastelOrange: ColorItem = "FFF5E5"
	/// #D1F8D8
	static var pastelGreen: ColorItem = "D1F8D8"
}

public extension View {
	func foregroundColor(_ colorItem: ColorItem) -> some View {
		foregroundStyle(colorItem.color)
	}

	func backgroundColor(_ colorItem: ColorItem) -> some View {
		background(colorItem.color)
	}
	
	func tint(_ colorItem: ColorItem) -> some View {
		tint(colorItem.color)
	}
}

public extension Shape {
	func fill(_ color: ColorItem, style: FillStyle = FillStyle()) -> some View {
		fill(color.color, style: style)
	}

	func stroke(_ color: ColorItem, style: StrokeStyle) -> some View {
		stroke(color.color, style: style)
	}

	func stroke(_ color: ColorItem, lineWidth: CGFloat = 1) -> some View {
		stroke(color.color, lineWidth: lineWidth)
	}
}

#if DEBUG
struct ColorItems_Previews: PreviewProvider {
	static let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)

	static var previews: some View {
		ScrollView {
			LazyVGrid(columns: gridColumns, spacing: 10) {
				color(title: "foregroundPrimary", color: .foregroundPrimary, textColor: .basicWhite)
				color(title: "foregroundSecondary", color: .foregroundSecondary, textColor: .basicWhite)
				color(title: "foregroundDisabled", color: .foregroundDisabled)
				color(title: "foregroundOnPrimary", color: .foregroundOnPrimary, stroke: true)
				
				Divider().padding(.vertical)
				Divider().padding(.vertical)
				
				color(title: "iconPrimary", color: .iconPrimary)
				color()
				
				Divider().padding(.vertical)
				Divider().padding(.vertical)
				
				color(title: "backgroundPrimary", color: .backgroundPrimary, stroke: true)
				color(title: "backgroundSecondary", color: .backgroundSecondary, stroke: true)
				
				Divider().padding(.vertical)
				Divider().padding(.vertical)
				
				color(title: "basicWhite", color: .basicWhite, stroke: true)
				color(title: "basicBlack", color: .basicBlack, textColor: .basicWhite)
				color(title: "basicMagenta", color: .basicMagenta)
				color(title: "basicBlue", color: .basicBlue)
				color(title: "darkBlue", color: .darkBlue, textColor: .basicWhite)
				color(title: "basicRed", color: .basicRed)
				color(title: "basicOrange", color: .basicOrange)
				color(title: "basicGreen", color: .basicGreen)
				
				Divider().padding(.vertical)
				Divider().padding(.vertical)
				
				color(title: "pastelMagenta", color: .pastelMagenta)
				color(title: "pastelBlue", color: .pastelBlue)
				color(title: "pastelGray", color: .pastelGray)
				color(title: "pastelRed", color: .pastelRed)
				color(title: "pastelOrange", color: .pastelOrange)
				color(title: "pastelGreen", color: .pastelGreen)
			}
			.padding(.horizontal)
		}
	}

	static func color(
		title: String = "",
		color: ColorItem = "FFFFFF",
		textColor: ColorItem = "000000",
		stroke: Bool = false
	) -> some View {
		RoundedRectangle(cornerRadius: 5)
			.fill(color)
			.overlay(alignment: .topLeading) {
				Text(title)
					.font(.system(size: 11, weight: .bold))
					.foregroundColor(textColor)
					.padding(8)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.aspectRatio(2, contentMode: .fit)
			.background {
				if stroke {
					RoundedRectangle(cornerRadius: 5)
						.stroke(.init(hex: "CDCDCD"), lineWidth: 2)
				}
			}
			.padding(.horizontal, 5)
	}
}
#endif
