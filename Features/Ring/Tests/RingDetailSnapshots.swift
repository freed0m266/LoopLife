//
//  RingDetailSnapshots.swift
//	Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import iRingsTesting
@testable import Ring

class RingDetailSnapshots: XCTestCase {
	func testPreviews() {
		let view = RingDetailView(viewModel: RingDetailViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
