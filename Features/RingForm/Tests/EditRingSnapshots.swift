//
//  EditRingSnapshots.swift
//	RingForm
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import TempooTesting
@testable import RingForm

class EditRingSnapshots: XCTestCase {
	func testPreviews() {
		let view = EditRingView(viewModel: EditRingViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
