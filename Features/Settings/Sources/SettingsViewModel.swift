//
//  SettingsViewModel.swift
//  Settings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore

public protocol SettingsViewModeling: ObservableObject {
	var version: String { get }
	var appUrl: URL { get }
}

public func settingsVM() -> some SettingsViewModeling {
	SettingsViewModel(dependencies: dependencies.settings)
}

final class SettingsViewModel: BaseViewModel, SettingsViewModeling {
	
	var appUrl: URL {
		// swiftlint:disable:next force_unwrapping
		URL(string: Environment.appLinkUrlString)!
	}
	
	var version: String {
		guard let version = Bundle.main.version else { return "" }
		return "v\(version)"
	}
	
    private let dependencies: SettingsDependencies
	
    // MARK: - Init

	init(dependencies: SettingsDependencies) {
        self.dependencies = dependencies
		super.init()
		setupBindings()
    }
	
	// MARK: - Private API
	
	private func setupBindings() {
		
	}
}
