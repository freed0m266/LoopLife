//
//  ListDivider.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

struct ListDividerModifier: ViewModifier {
	let isShown: Bool
	let padding: CGFloat
	
	func body(content: Content) -> some View {
		content
			.overlay(alignment: .bottom) {
				if isShown {
					Rectangle()
						.fill(.pastelGray)
						.frame(height: 1)
						.padding(.leading, padding)
				}
			}
	}
}

extension ListButton {
	func listDivider(isShown: Bool) -> some View {
		modifier(ListDividerModifier(isShown: isShown, padding: icon == nil ? 16 : 48))
	}
}
