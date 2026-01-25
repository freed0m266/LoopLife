//
//  SettingsViewModelMock.swift
//  Settings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore

final class SettingsViewModelMock: SettingsViewModeling {
	// swiftlint:disable:next force_unwrapping
	var appUrl = URL(string: Environment.appLinkUrlString)!
	var version = "v26.4.12"
}
