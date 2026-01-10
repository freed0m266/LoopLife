//
//  WithDismissButton.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

struct WithDismissButtonModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Button {
						content.closeSheet()
					} label: {
						Icon.xmark.size(15, weight: .medium)
							.largerTapArea()
					}
				}
			}
	}
}

public extension View {
	func withDismissButton() -> some View {
		modifier(WithDismissButtonModifier())
	}
}
