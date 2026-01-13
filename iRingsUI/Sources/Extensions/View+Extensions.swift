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
	/// When app is entering to background
	func onBackground(action: @escaping () -> Void) -> some View {
		onReceive(
			NotificationCenter.default.publisher(
				for: UIApplication.willResignActiveNotification
			),
			perform: { _ in action() }
		)
	}
	
	/// When app did enter background
	func didEnterBackground(action: @escaping () -> Void) -> some View {
		onReceive(
			NotificationCenter.default.publisher(
				for: UIApplication.didEnterBackgroundNotification
			),
			perform: { _ in action() }
		)
	}
	
	/// When app will enter foreground
	func willEnterForeground(action: @escaping () -> Void) -> some View {
		onReceive(
			NotificationCenter.default.publisher(
				for: UIApplication.willEnterForegroundNotification
			),
			perform: { _ in action() }
		)
	}
	
	/// When app did enter foreground
	func onForeground(action: @escaping () -> Void) -> some View {
		onReceive(
			NotificationCenter.default.publisher(
				for: UIApplication.didBecomeActiveNotification
			),
			perform: { _ in action() }
		)
	}
}
