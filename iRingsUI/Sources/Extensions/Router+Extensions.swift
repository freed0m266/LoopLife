//
//  Router+Extensions.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsCore

public extension View {
	var isSheetShown: Bool {
		router.sheetItem != nil
	}
	
	func navigateTo(route: Route) {
		router.navigateTo(route: route)
	}
	
	func navigateBack() {
		router.navigateBack()
	}
	
	func cleanNavigation(path: RoutePath? = nil) {
		router.cleanNavigation(path: path)
	}
	
	func presentSheet(item: Route, onDismiss: (() -> Void)? = nil) {
		router.presentSheet(item: item, onDismiss: onDismiss)
	}

	func closeSheet() {
		router.closeSheet()
	}
	
	func presentToast(item: ToastItem, duration: TimeInterval = 2.0) {
		router.presentToast(item: item, duration: duration)
	}
	
	func setActive(path: RoutePath) {
		router.setActive(path: path)
	}
}

fileprivate extension View {
	var router: Router { .default }
}
