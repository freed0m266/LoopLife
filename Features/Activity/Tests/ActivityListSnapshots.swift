//
//  ActivityListSnapshots.swift
//  Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import LoopLifeTesting
@testable import Activity

class ActivityListSnapshots: XCTestCase {
	func testPreviews() {
		let view = ActivityListView(viewModel: ActivityListViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
