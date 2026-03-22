//
//  ToastModifier.swift
//  TempooUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import TempooCore

struct ToastModifier: ViewModifier {
	@Binding var item: ToastItem?

	func body(content: Content) -> some View {
		content
			.overlay(alignment: .top) {
				ToastView(item: $item)
			}
			.animation(.snappy, value: item)
	}
}

public extension View {
	func toast(_ item: Binding<ToastItem?>) -> some View {
		modifier(ToastModifier(item: item))
	}
}
