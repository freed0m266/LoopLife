//
//  BaseViewModel.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import ACKategories

open class BaseViewModel: Base.ViewModel {
	
	// MARK: - Init
	
	public override init() {
		super.init()
	}
}

public extension BaseViewModel {
	func navigateTo(route: Route) {
		DispatchQueue.main.async { [weak self] in
			self?.router.navigateTo(route: route)
		}
	}
	
	func navigateBack() {
		DispatchQueue.main.async { [weak self] in
			self?.router.navigateBack()
		}
	}
	
	func presentSheet(item: Route, onDismiss: (() -> Void)? = nil) {
		DispatchQueue.main.async { [weak self] in
			self?.router.presentSheet(item: item, onDismiss: onDismiss)
		}
	}
	
	func closeSheet() {
		DispatchQueue.main.async { [weak self] in
			self?.router.closeSheet()
		}
	}
	
	func presentToast(item: ToastItem, duration: TimeInterval = 3.0) {
		DispatchQueue.main.async { [weak self] in
			self?.router.presentToast(item: item, duration: duration)
		}
	}
}

fileprivate extension BaseViewModel {
	var router: Router { .default }
}
