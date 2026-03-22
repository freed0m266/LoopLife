//
//  SettingsDependencies.swift
//  Settings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import TempooCore

public struct SettingsDependencies {
	let dataMigrationManager: DataMigrationManaging
}

extension AppDependency {
	var settings: SettingsDependencies {
		.init(
			dataMigrationManager: dataMigrationManager
		)
	}
}
