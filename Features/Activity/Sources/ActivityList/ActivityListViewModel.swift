//
//  ActivityListViewModel.swift
//  Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import Combine
import LoopLifeCore

public protocol ActivityListViewModeling: ObservableObject {
	var activities: [Activity] { get }
	var currentDate: Date { get }
	
	func recordLog(of: Activity.Category)
	func willEnterForeground()
}

public func activityListVM() -> some ActivityListViewModeling {
	ActivityListViewModel(dependencies: dependencies.activityList)
}

final class ActivityListViewModel: BaseViewModel, ActivityListViewModeling {
	@Published var activities: [Activity] = []
	@Published var currentDate: Date = .now
	
    private let dependencies: ActivityListDependencies

    // MARK: - Init

    init(dependencies: ActivityListDependencies) {
        self.dependencies = dependencies
		super.init()
		setupBindings()
	}
	
	// MARK: - Public API
	
	func recordLog(of: Activity.Category)) {
		// TODO: Implement
		
	}
	
	func willEnterForeground() {
		currentDate = .now
	}
	
	// MARK: - Private API
	
	private func setupBindings() {
		dependencies.activitiesRepository.activities()
			.assign(to: \.activities, on: self)
	}
}
