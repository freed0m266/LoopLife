//
//  ActivityDetailDependencies.swift
//  Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import LoopLifeCore

public struct ActivityDetailDependencies {
	let activitiesRepository: ActivitiesRepositoring
}

extension AppDependency {
	var activityDetail: ActivityDetailDependencies {
		.init(
			activitiesRepository: activitiesRepository
		)
	}
}
