//
//  BaseViewModel.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import Combine
import ACKategories

open class BaseViewModel: Base.ViewModel {
	
	public var cancellables = Set<AnyCancellable>()
	
	private let router: Router = .default
	
	// MARK: - Init
	
	public override init() {
		super.init()
	}
	
	// MARK: - Public API
	
	public func showError(_ error: Error) {
		// TODO: Implement
		
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

extension Publisher {
	/// Handles error and assigns `newValue` to the given `keyPath`
	public func assign<Root: BaseViewModel>(
		to keyPath: ReferenceWritableKeyPath<Root, Output>,
		on viewModel: Root
	) {
		self
			.receive(on: DispatchQueue.main)
			.sink { [weak viewModel] completion in
				if case let .failure(error) = completion {
					viewModel?.showError(error)
				}
			} receiveValue: { [weak viewModel] newValue in
				viewModel?[keyPath: keyPath] = newValue
			}
			.store(in: &viewModel.cancellables)
	}
}
