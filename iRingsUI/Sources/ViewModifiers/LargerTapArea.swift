//
//  LargerTapArea.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 09.01.2026.
//  Copyright © 2026 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

struct LargerTapAreaModifier: ViewModifier {
	let verticalPadding: CGFloat
	let horizontalPadding: CGFloat
	
	func body(content: Content) -> some View {
		content
			.padding(.horizontal, horizontalPadding)
			.padding(.vertical, verticalPadding)
			.backgroundColor(.backgroundPrimary.opacity(0.001))
	}
}

public extension View {
	func largerTapArea(
		verticalPadding: CGFloat = 6,
		horizontalPadding: CGFloat = 0
	) -> some View {
		modifier(
			LargerTapAreaModifier(
				verticalPadding: verticalPadding,
				horizontalPadding: horizontalPadding
			)
		)
	}
}
