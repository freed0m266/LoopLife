//
//  PrimaryButtonStyle.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) var isEnabled
	
	let foreground: ColorItem
	let background: ColorItem
	let cornerRadius: CGFloat
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.frame(height: 24)
			.padding(12)
			.foregroundColor(foreground(isPressed: configuration.isPressed))
			.backgroundColor(background(isPressed: configuration.isPressed))
			.cornerRadius(cornerRadius)
	}
	
	private func foreground(isPressed: Bool) -> ColorItem {
		isEnabled ? foreground : .foregroundDisabled
	}
	
	private func background(isPressed: Bool) -> ColorItem {
		if isEnabled {
			isPressed ? background.opacity(0.7) : background
		} else {
			.backgroundDisabled
		}
	}
}
