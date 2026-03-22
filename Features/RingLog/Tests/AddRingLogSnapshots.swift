//
//  AddRingLogSnapshots.swift
//	RingLog
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import TempooTesting
@testable import RingLog

class AddRingLogSnapshots: XCTestCase {
	func testPreviews() {
		let view = AddRingLogView(viewModel: AddRingLogViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
