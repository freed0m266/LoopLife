//
//  ActivityDetailSnapshots.swift
//	Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import LoopLifeTesting
@testable import Activity

class ActivityDetailSnapshots: XCTestCase {
	func testPreviews() {
		let view = ActivityDetailView(viewModel: ActivityDetailViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
