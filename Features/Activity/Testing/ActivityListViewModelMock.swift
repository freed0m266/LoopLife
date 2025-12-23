//
//  ActivityListViewModelMock.swift
//  Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import LoopLifeCore

final class ActivityListViewModelMock: ActivityListViewModeling {
	var activities: [Activity] = .mock
	var currentDate: Date = .mock2026
	
	func recordLog(of: Activity.Category) { }
	func willEnterForeground() { }
}
