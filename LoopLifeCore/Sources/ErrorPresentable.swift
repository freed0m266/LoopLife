//
//  ErrorPresentable.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public protocol ErrorPresentable: Error {
	var title: String { get }
	var message: String { get }
}

public extension View {
	func error<T: ErrorPresentable>(_ error: Binding<T?>) -> some View {
		alert(
			Text(error.wrappedValue?.title ?? ""),
			isPresented: Binding(
				get: { error.wrappedValue != nil },
				set: {
					guard !$0 else { return }
					error.wrappedValue = nil
				}
			),
			actions: {

			},
			message: { Text(error.wrappedValue?.message ?? "") }
		)
	}
}
