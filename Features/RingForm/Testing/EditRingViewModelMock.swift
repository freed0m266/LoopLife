//
//  EditRingViewModelMock.swift
//	RingForm
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore

final class EditRingViewModelMock: EditRingViewModeling {
	@Published var name: String? = "Workout"
	@Published var targetCount: Int? = 100
	@Published var startDate: Date = .mock2077.startOfYear
	@Published var endDate: Date = .mock2077

	var isSaveButtonDisabled: Bool = false
	
	func saveRing() { }
}
