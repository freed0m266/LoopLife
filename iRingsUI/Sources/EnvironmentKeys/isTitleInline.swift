//
//  isTitleInline.swift
//  AccountDelete
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

struct IsTitleInlineEnvironmentKey: EnvironmentKey {
	static var defaultValue: Bool = false
}

extension EnvironmentValues {
	var isTitleInline: Bool {
		get { self[IsTitleInlineEnvironmentKey.self] }
		set { self[IsTitleInlineEnvironmentKey.self] = newValue }
	}
}

extension View {
	public func isTitleInline(_ value: Bool = true) -> some View {
		environment(\.isTitleInline, value)
	}
}
