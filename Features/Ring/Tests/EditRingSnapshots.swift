//
//  EditRingSnapshots.swift
//	Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import iRingsTesting
@testable import Ring

class EditRingSnapshots: XCTestCase {
	func testPreviews() {
		let view = EditRingView(viewModel: EditRingViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
