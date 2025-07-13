//
//  UndefinedRouteSnapshots.swift
//  UndefinedRoute
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import XCTest
import LoopLifeTesting
@testable import UndefinedRoute

class UndefinedRouteSnapshots: XCTestCase {
	func testPreviews() {
		let view = UndefinedRouteView().inPreview()
		AssertSnapshot(view)
	}
}
