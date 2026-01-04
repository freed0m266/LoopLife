//
//  LLTextField.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct LLTextField: View {
	@State private var inputString = ""
	@Binding private var text: String?
	@FocusState private var isActive: Bool
	
	private let textColor: ColorItem
	private let placeholder: String
	private let headline: String?
	private let initialValueIsActive: Bool
	
	public init(
		headline: String? = nil,
		text: Binding<String?>,
		textColor: ColorItem = .foregroundPrimary,
		placeholder: String = "",
		isActive: Bool = false
	) {
		self.headline = headline
		self._text = text
		self.textColor = textColor
		self.placeholder = placeholder
		self.initialValueIsActive = isActive
	}
	
	public var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			if let headline {
				LLHeadline(headline)
			}
			
			TextField(
				"",
				text: Binding(
					get: { inputString },
					set: { inputString = $0 }
				),
				prompt: Text(placeholder).foregroundColor(
					ColorItem.foregroundPlaceholder.color
				)
			)
			.titleLarge()
			.padding(.vertical, 12)
			.padding(.horizontal, 16)
			.foregroundColor(textColor)
			.background {
				LinearGradient.backgroundSoft
			}
			.cornerRadius(16)
			.focused($isActive)
			.onChange(of: inputString) { _, newValue in
				// Clear value if input is empty
				text = newValue.isEmpty ? nil : newValue
			}
			.onAppear {
				isActive = initialValueIsActive
				// Initialize the input string
				if let text {
					inputString = text
				}
			}
			.onTapGesture {
				isActive = true
			}
		}
	}
}

#if DEBUG
#Preview {
	VStack(spacing: 24) {
		LLTextField(
			headline: "headline",
			text: .constant(""),
			placeholder: "placeholder"
		)
		
		LLTextField(
			headline: "headline",
			text: .constant("text"),
			placeholder: "placeholder"
		)
	}
	.padding(16)
	.frame(maxWidth: .infinity, maxHeight: .infinity)
	.backgroundColor(.backgroundPrimary)
}
#endif
