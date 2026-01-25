//
//  View+Extensions.swift
//  iRings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public extension View {
	func measureSizeOnChange<V>(
		of value: V,
		action: @escaping (CGSize) -> Void
	) -> some View where V: Equatable {
		overlay {
			GeometryReader { proxy in
				Color.clear
					.onAppear {
						action(proxy.size)
					}
					.onChange(of: value) {
						action(proxy.size)
					}
			}
		}
	}
}

public extension View {
	/// When app will enter foreground
	func willEnterForeground(action: @escaping () -> Void) -> some View {
		onReceive(
			NotificationCenter.default.publisher(
				for: UIApplication.willEnterForegroundNotification
			),
			perform: { _ in action() }
		)
	}
	
	/// When keyboard shown
	func keyboardResponder(action: @escaping (Bool) -> Void) -> some View {
		onReceive(
			NotificationCenter.default.publisher(
				for: UIApplication.keyboardWillShowNotification
			),
			perform: { _ in action(true) }
		)
		.onReceive(
			NotificationCenter.default.publisher(
				for: UIApplication.keyboardWillHideNotification
			),
			perform: { _ in action(false) }
		)
		
	}
}
