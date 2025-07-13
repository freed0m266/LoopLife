//
//  ActivityListDependencies.swift
//  Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import LoopLifeCore

public struct ActivityListDependencies {
	let activitiesRepository: ActivitiesRepositoring
}

extension AppDependency {
	var activityList: ActivityListDependencies {
		.init(
			activitiesRepository: activitiesRepository
		)
	}
}
