//
//  ActivityListViewModel.swift
//  Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Combine
import LoopLifeCore

public protocol ActivityListViewModeling: ObservableObject {
	var activities: [Activity] { get }
}

public func activityListVM() -> some ActivityListViewModeling {
	ActivityListViewModel(dependencies: dependencies.activityList)
}

final class ActivityListViewModel: BaseViewModel, ActivityListViewModeling {
	@Published var activities: [Activity] = []
	
    private let dependencies: ActivityListDependencies

    // MARK: - Init

    init(dependencies: ActivityListDependencies) {
        self.dependencies = dependencies
		super.init()
		setupBindings()
	}
	
	// MARK: - Private API
	
	private func setupBindings() {
		
	}
}
