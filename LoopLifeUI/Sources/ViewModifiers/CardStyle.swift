//
//  CardStyle.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 22.09.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

struct CardStyleModifier: ViewModifier {
	let verticalPadding: CGFloat
	let horizontalPadding: CGFloat
	let backgroundGradient: LinearGradient
	let opacity: CGFloat
	let cornerRadius: CGFloat
	
	func body(content: Content) -> some View {
		content
			.padding(.horizontal, horizontalPadding)
			.padding(.vertical, verticalPadding)
			.background {
				backgroundGradient
					.opacity(opacity)
					.cornerRadius(cornerRadius)
			}
	}
}

public extension View {
	func cardStyle(
		verticalPadding: CGFloat = 16,
		horizontalPadding: CGFloat = 16,
		backgroundGradient: LinearGradient = .backgroundSoft,
		opacity: CGFloat = 1.0,
		cornerRadius: CGFloat = 16
	) -> some View {
		modifier(
			CardStyleModifier(
				verticalPadding: verticalPadding,
				horizontalPadding: horizontalPadding,
				backgroundGradient: backgroundGradient,
				opacity: opacity,
				cornerRadius: cornerRadius
			)
		)
	}
}
