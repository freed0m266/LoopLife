//
//  ActivityDetailViewModel.swift
//  Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Combine
import LoopLifeCore

public protocol ActivityDetailViewModeling: ObservableObject {
	var activity: Activity? { get }
}

public func activityDetailVM(id: Activity.ID) -> some ActivityDetailViewModeling {
	ActivityDetailViewModel(dependencies: dependencies.activityDetail, id: id)
}

final class ActivityDetailViewModel: BaseViewModel, ActivityDetailViewModeling {
	@Published var activity: Activity?
	@Published var activityLogs: [ActivityLog] = []
	
    private let dependencies: ActivityDetailDependencies
	private let id: Activity.ID
	
    // MARK: - Init

	init(dependencies: ActivityDetailDependencies, id: Activity.ID) {
        self.dependencies = dependencies
		self.id = id
		super.init()
		setupBindings()
    }
	
	// MARK: - Private API
	
	private func setupBindings() {
		
	}
}
