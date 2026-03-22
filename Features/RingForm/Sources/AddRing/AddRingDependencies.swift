//
//  AddRingDependencies.swift
//	RingForm
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import TempooCore

public struct AddRingDependencies {
	let ringsRepository: RingsRepositoring
}

extension AppDependency {
	var addRing: AddRingDependencies {
		.init(
			ringsRepository: ringsRepository
		)
	}
}
