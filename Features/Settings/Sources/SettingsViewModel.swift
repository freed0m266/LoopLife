//
//  SettingsViewModel.swift
//  Settings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Combine
import iRingsCore

public protocol SettingsViewModeling: ObservableObject {
	
}

public func settingsVM() -> some SettingsViewModeling {
	SettingsViewModel(dependencies: dependencies.settings)
}

final class SettingsViewModel: BaseViewModel, SettingsViewModeling {
	
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
