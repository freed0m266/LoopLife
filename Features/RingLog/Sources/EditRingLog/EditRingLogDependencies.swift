//
//  EditRingLogDependencies.swift
//  RingLog
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import TempooCore

public struct EditRingLogDependencies {
	let ringsRepository: RingsRepositoring
}

extension AppDependency {
	var editRingLog: EditRingLogDependencies {
		.init(
			ringsRepository: ringsRepository
		)
	}
}
