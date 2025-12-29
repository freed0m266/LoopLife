//
//  EditRingLogViewModelMock.swift
//  RingLog
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import LoopLifeCore

final class EditRingLogViewModelMock: EditRingLogViewModeling {
	@Published var date: Date = .now
	var ring: Ring? = .mock1
	var isEditButtonDisabled: Bool = false
	
	func editRingLog() { }
}
