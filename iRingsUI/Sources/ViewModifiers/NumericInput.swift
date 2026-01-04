//
//  NumericInput.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsCore

struct NumericInputModifier: ViewModifier {
	@Binding var text: String
	
	func body(content: Content) -> some View {
		content
			.onChange(of: text) { _, newValue in
				let filtered = newValue.filter { "0123456789".contains($0) }
				if filtered != newValue {
					text = filtered
				}
			}
	}
}

public extension View {
	func numericInput(text: Binding<String>) -> some View {
		self.modifier(NumericInputModifier(text: text))
	}
}
