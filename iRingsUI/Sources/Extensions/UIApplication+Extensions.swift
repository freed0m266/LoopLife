//
//  UIApplication+Extensions.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import UIKit

extension UIApplication {
	static func resignFirstResponder() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
	
	static func openSystemSettings() {
		if let settingsURL = URL(string: openSettingsURLString) {
			shared.open(settingsURL)
		}
	}
}
