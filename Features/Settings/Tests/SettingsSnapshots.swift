//
//  SettingsSnapshots.swift
//  Settings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import TempooTesting
@testable import Settings

class SettingsSnapshots: XCTestCase {
	func testPreviews() {
		let view = SettingsView(viewModel: SettingsViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
