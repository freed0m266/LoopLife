//
//  RingListDependencies.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import TempooCore

public struct RingListDependencies {
	let ringsRepository: RingsRepositoring
}

extension AppDependency {
	var ringList: RingListDependencies {
		.init(
			ringsRepository: ringsRepository
		)
	}
}
