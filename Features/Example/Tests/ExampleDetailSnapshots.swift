//
//  ExampleDetailSnapshots.swift
//	Example
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import LoopLifeTesting
@testable import Example

class ExampleDetailSnapshots: XCTestCase {
	func testPreviews() {
		let view = ExampleDetailView(viewModel: ExampleDetailViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
