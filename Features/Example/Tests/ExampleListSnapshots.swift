//
//  ExampleListSnapshots.swift
//  Example
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import LoopLifeTesting
@testable import Example

class ExampleListSnapshots: XCTestCase {
	func testPreviews() {
		let view = ExampleListView(viewModel: ExampleListViewModelMock()).inPreview()
		AssertSnapshot(view)
	}
}
