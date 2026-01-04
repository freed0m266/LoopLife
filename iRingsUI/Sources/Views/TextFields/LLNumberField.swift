//
//  LLNumberField.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 25.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct LLNumberField<T: FormattableNumber>: View {
	@State private var inputString = ""
	@Binding private var number: T?
	@FocusState private var isActive: Bool
	
	private let numberColor: ColorItem
	private let maxNumberLength: Int
	private let maxDecimalLength: Int
	private let placeholder: String
	private let headline: String?
	private let initialValueIsActive: Bool
	
	public init(
		headline: String? = nil,
		number: Binding<T?>,
		numberColor: ColorItem = .foregroundPrimary,
		placeholder: String = "",
		maxNumberLength: Int = 5,
		maxDecimalLength: Int = 0,
		isActive: Bool = false
	) {
		self.headline = headline
		self._number = number
		self.numberColor = numberColor
		self.placeholder = placeholder
		self.maxNumberLength = maxNumberLength
		self.maxDecimalLength = maxDecimalLength
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
			.foregroundColor(numberColor)
			.background {
				LinearGradient.backgroundSoft
			}
			.cornerRadius(16)
			.keyboardType(.decimalPad)
			.focused($isActive)
			.onChange(of: inputString) { _, newValue in
				// Prevents entering a decimal separator if no decimal places are allowed
				guard maxDecimalLength > 0 || newValue.last?.isNumber ?? true else {
					inputString = String(newValue.dropLast())
					return
				}
				
				// Normalize decimal separator and truncate fractional part to max two digits
				let decimalSeparator = NumberFormatter.decimal.decimalSeparator ?? "."
				let altDecimalSeparator = decimalSeparator == "," ? "." : ","
				
				// Replace alternative decimal separator with the standard one if present at the end
				var text: String = {
					if newValue.hasSuffix(altDecimalSeparator) {
						newValue.dropLast() + decimalSeparator
					} else {
						newValue
					}
				}()
				
				// Restrict to a maximum of two digits after the decimal separator
				if let sepChar = decimalSeparator.first, let sepIndex = text.firstIndex(of: sepChar) {
					let fracStart = text.index(after: sepIndex)
					let fracPart = text[fracStart...]
					
					if fracPart.count > maxDecimalLength {
						let endIndex = text.index(sepIndex, offsetBy: 1 + maxDecimalLength)
						text = String(text[..<endIndex])
					}
				}
				
				// If normalization or truncation occurred, update and bail out
				if text != newValue {
					inputString = text
					return
				}
				
				// Clear value if input is empty
				if text.isEmpty {
					number = nil
					return
				}
				
				// Attempt to parse the normalized text
				guard let validNumber = T(localizedText: text.withoutSpaces) else {
					// Revert to last valid formatted value on parse failure
					inputString = number?.formatted(maxPrecision: maxDecimalLength) ?? ""
					return
				}
				number = validNumber
			}
			.onChange(of: number) { _, newValue in
				// Update display when the bound number changes externally
				guard let numberText = newValue?.formatted(maxPrecision: maxDecimalLength) else {
					inputString = ""
					return
				}
				
				// Enforce max total digits if needed
				let digitCount = numberText.filter(\.isNumber).count
				
				if digitCount <= maxNumberLength {
					inputString = numberText
				} else {
					inputString = String(numberText.dropLast(digitCount - maxNumberLength))
				}
			}
			.onAppear {
				isActive = initialValueIsActive
				// Initialize the input string with the formatted number if available
				if let number {
					inputString = number.formatted(maxPrecision: maxDecimalLength)
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
		LLNumberField(
			number: .constant(80.5),
			placeholder: "80"
		)
		.padding(.horizontal, 16)
		
		LLNumberField(
			number: .constant(nil as Int?),
			placeholder: "10 000"
		)
		.padding(.horizontal, 16)
	}
	.frame(maxWidth: .infinity, maxHeight: .infinity)
	.backgroundColor(.backgroundPrimary)
}
#endif
