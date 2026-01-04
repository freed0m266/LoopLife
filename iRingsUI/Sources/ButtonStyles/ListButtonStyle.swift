//
//  ListButtonStyle.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

struct ListButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) var isEnabled
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.opacity(configuration.isPressed || !isEnabled ? 0.7 : 1)
	}
}
