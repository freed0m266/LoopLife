//
//  LLDatePicker.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct LLDatePicker: View {
	@Binding private var date: Date
	
	private let headline: String?
	private let text: String
	private let textColor: ColorItem
	
	private let dateComponents: DatePicker<Text>.Components

	public init(
		headline: String? = nil,
		date: Binding<Date>,
		dateComponents: DatePicker<Text>.Components,
		text: String,
		textColor: ColorItem
	) {
		self.headline = headline
		self._date = date
		self.dateComponents = dateComponents
		self.text = text
		self.textColor = textColor
	}
	public var body: some View {
		VStack(spacing: 0) {
			if let headline {
				LLHeadline(headline)
			}
			
			DatePicker(
				text,
				selection: $date,
				displayedComponents: dateComponents
			)
			.titleLarge()
			.foregroundColor(textColor)
			.animation(.default, value: text)
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
		dateComponents: .date,
		text: "26 days",
		textColor: .basicMagenta
	)
	.padding(16)
}
