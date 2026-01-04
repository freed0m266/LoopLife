//
//  RingListSnapshots.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import iRingsTesting
@testable import Ring

class RingListSnapshots: XCTestCase {
	func testPreviews() {
		let view = RingListView(viewModel: RingListViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
