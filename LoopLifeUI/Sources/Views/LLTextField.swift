//
//  LLTextField.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct LLTextField: View {
	@Binding var text: String
	
	@Environment(\.isEnabled) private var isEnabled
	@FocusState private var isActive: Bool
	private let initialValueIsActive: Bool
	
	private let placeholder: String
	private let headline: String?
	private let error: String?
	private let maxLength: Int?
	
	public init(
		_ placeholder: String,
		text: Binding<String>,
		headline: String? = nil,
		error: String? = nil,
		maxLength: Int? = nil,
		isActive: Bool = false
	) {
		self.placeholder = placeholder
		self._text = text
		self.headline = headline
		self.error = error
		self.maxLength = maxLength
		self.initialValueIsActive = isActive
	}
	
	public init(
		text: Binding<String>,
		headline: String,
		error: String? = nil,
		maxLength: Int? = nil,
		isActive: Bool = false
	) {
		self.placeholder = headline
		self._text = text
		self.headline = headline
		self.error = error
		self.maxLength = maxLength
		self.initialValueIsActive = isActive
	}
	
	public var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			if let headline {
				LLHeadline(headline)
			}
			
			TextField("", text: $text, prompt: Text(placeholder).foregroundColor(ColorItem.foregroundDisabled.color))
				.focused($isActive)
				.padding(.vertical, 14)
				.padding(.horizontal, 16)
				.foregroundColor(isEnabled ? .foregroundPrimary : .foregroundDisabled)
				.backgroundColor(isEnabled ? .basicWhite : .pastelGray)
				.cornerRadius(10)
				.background {
					if isActive {
						RoundedRectangle(cornerRadius: 10)
							.stroke(.pastelBlue, lineWidth: 0.5)
					}
				}
				.overlay {
					if error != nil {
						RoundedRectangle(cornerRadius: 10)
							.stroke(.basicRed, lineWidth: 0.5)
					}
				}
				.shadow(
					color: ColorItem.pastelGray.color.opacity(isActive ? 1 : 0),
					radius: 4,
					x: 0,
					y: 4
				)
				.onChange(of: text) { _, newValue in
					if let maxLength, maxLength < newValue.count {
						text = String(newValue.prefix(maxLength))
					}
				}
				.onAppear {
					isActive = initialValueIsActive
				}
				.onTapGesture {
					// Thanks to this, even the padding of TextField is tapable
					isActive = true
				}
			
			if let error {
				errorText(text: error)
			}
		}
	}
	
	private func errorText(text: String) -> some View {
		Text(text)
			.textSmall()
			.foregroundColor(.basicRed)
			.padding(.vertical, 4)
			.padding(.horizontal, 16)
	}
}

#if DEBUG
#Preview {
	VStack(spacing: 16) {
		LLTextField("Placeholder", text: .constant(""), headline: "headline")
		
		LLTextField("Label", text: .constant("Teeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeext"))
		
		LLTextField("Label", text: .constant("Text"), error: "Error message")
		
		LLTextField("Placeholder", text: .constant("Text"))
			.disabled(true)
	}
	.padding()
	.backgroundColor(.backgroundPrimary)
}
#endif
