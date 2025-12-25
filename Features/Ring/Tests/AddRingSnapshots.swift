//
//  AddRingSnapshots.swift
//	Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import LoopLifeTesting
@testable import Ring

class AddRingSnapshots: XCTestCase {
	func testPreviews() {
		let view = AddRingView(viewModel: AddRingViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
