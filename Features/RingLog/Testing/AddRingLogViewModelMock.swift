//
//  AddRingLogViewModelMock.swift
//  RingLog
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore

final class AddRingLogViewModelMock: AddRingLogViewModeling {
	@Published var ring: Ring? = .mock1
	@Published var date: Date = .now
	@Published var note: String?
	
	func saveRingLog() { }
}
