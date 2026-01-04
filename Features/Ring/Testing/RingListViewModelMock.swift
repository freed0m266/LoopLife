//
//  RingListViewModelMock.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore

final class RingListViewModelMock: RingListViewModeling {
	var rings: [Ring] = .mock
	var currentDate: Date = .mock2026
	
	func recordLog(for ring: Ring) { }
	func willEnterForeground() { }
}
