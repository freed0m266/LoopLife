//
//  WithDismissButton.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

struct WithDismissButtonModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.toolbar {
				ToolbarItem(placement: .destructiveAction) {
					Button {
						content.closeSheet()
					} label: {
						Icon.xmarkFill
							.foregroundColor(.foregroundSecondary)
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
