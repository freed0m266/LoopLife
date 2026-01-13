//
//  Router.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import Combine

public final class Router: ObservableObject {
	public static let `default` = Router()
	
	@Published public var toastItem: ToastItem?
	@Published public var sheetItem: Route?
	
	@Published public var examplePath: [Route] = []
	@Published public var homePath: [Route] = []
	@Published public var sheetPath: [Route] = []
	
	private var activePath: RoutePath?
	private var previousPath: RoutePath?

	private var dismissAction: (() -> Void)?
	private var cancellables = Set<AnyCancellable>()
	
	// MARK: - Init
	
	init() {
		setupBindings()
	}
	
	// MARK: - Internal API
	
	public func navigateTo(route: Route) {
		switch activePath {
		case .example:
			examplePath.append(route)
		case .home:
			homePath.append(route)
		case .sheet:
			sheetPath.append(route)
		case .none:
			break
		}
	}
	
	public func navigateBack() {
		switch activePath {
		case .example:
			examplePath.removeLast()
		case .home:
			homePath.removeLast()
		case .sheet:
			sheetPath.removeLast()
		case .none:
			break
		}
	}
	
	public func cleanNavigation(path: RoutePath?) {
		switch path {
		case .example:
			examplePath = []
		case .home:
			homePath = []
		case .sheet:
			sheetPath = []
		case .none:
			// Clear all paths
			examplePath = []
			homePath = []
			sheetPath = []
		}
	}
	
	public func presentSheet(item: Route, onDismiss: (() -> Void)?) {
		closeSheet()
		sheetPath = []
		
		sheetItem = item
		dismissAction = onDismiss
		
		if activePath != .sheet {
			previousPath = activePath
			activePath = .sheet
		}
	}
	
	public func closeSheet() {
		sheetItem = nil
	}
	
	public func presentToast(item: ToastItem, duration: TimeInterval) {
		toastItem = item
		Haptics.hapticFeedback(type: item.hapticType)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
			self?.toastItem = nil
		}
	}
	
	public func setActive(path: RoutePath) {
		activePath = path
	}
	
	// MARK: - Private API
	
	private func setupBindings() {
		$sheetItem
			.sink { [unowned self] newItem in
				if sheetItem != nil, newItem == nil {
					dismissAction?()
					dismissAction = nil
					
					if activePath == .sheet {
						activePath = previousPath
					}
				}
			}
			.store(in: &cancellables)
	}
}
