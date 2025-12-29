//
//  EditRingLogSnapshots.swift
//	RingLog
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import LoopLifeTesting
@testable import RingLog

class EditRingLogSnapshots: XCTestCase {
	func testPreviews() {
		let view = EditRingLogView(viewModel: EditRingLogViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
