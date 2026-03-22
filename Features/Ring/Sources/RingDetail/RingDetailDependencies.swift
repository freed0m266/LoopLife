//
//  RingDetailDependencies.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import TempooCore

public struct RingDetailDependencies {
	let ringsRepository: RingsRepositoring
}

extension AppDependency {
	var ringDetail: RingDetailDependencies {
		.init(
			ringsRepository: ringsRepository
		)
	}
}
