//
//  ToastModifier.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsCore

struct ToastModifier: ViewModifier {
	@Binding var item: ToastItem?

	func body(content: Content) -> some View {
		content
			.overlay(alignment: .top) {
				ToastView(item: $item)
			}
			.animation(.default, value: item)
	}
}

public extension View {
	func toast(_ item: Binding<ToastItem?>, isActive: Bool = true) -> some View {
		modifier(ToastModifier(item: item))
	}
}
