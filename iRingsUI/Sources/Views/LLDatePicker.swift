//
//  LLDatePicker.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct LLDatePicker: View {
	@Binding private var date: Date
	
	private let headline: String?
	private let title: String
	private let titleColor: ColorItem
	private let components: DatePicker<Text>.Components
	private let from: Date?
	private let to: Date?
	
	public init(
		headline: String? = nil,
		date: Binding<Date>,
		components: DatePicker<Text>.Components,
		title: String,
		titleColor: ColorItem,
		from: Date? = nil,
		to: Date? = nil
	) {
		self.headline = headline
		self._date = date
		self.components = components
		self.title = title
		self.titleColor = titleColor
		self.from = from
		self.to = to
	}
	public var body: some View {
		VStack(spacing: 0) {
			if let headline {
				LLHeadline(headline)
			}
			
			DatePicker(
				title,
				selection: $date,
				components: components,
				from: from,
				to: to
			)
			.titleLarge()
			.foregroundColor(titleColor)
			.animation(.default, value: title)
			.contentTransition(.numericText())
			.padding(.vertical, 12)
			.padding(.horizontal, 16)
			.background {
				LinearGradient.backgroundSoft
			}
			.cornerRadius(16)
		}
    }
}

#Preview {
	LLDatePicker(
		date: .constant(.now),
		components: .date,
		title: "26 days",
		titleColor: .basicMagenta
	)
	.padding(16)
}
