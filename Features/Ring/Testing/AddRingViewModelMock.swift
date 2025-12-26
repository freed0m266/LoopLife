//
//  AddRingViewModelMock.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import LoopLifeCore

final class AddRingViewModelMock: AddRingViewModeling {
	@Published var name: String? = "Workout"
	@Published var targetCount: Int? = 100
	@Published var endDate: Date = .mock2077

	var isSaveButtonDisabled: Bool = false
	var isEndDateFilled: Bool = true
	var progressRatioText: String? = "0/100"
	var daysRemaining: Int? = 266
	
	func saveRing() { }
}
