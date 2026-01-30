//
//  RingListViewModel.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import Combine
import iRingsCore
import iRingsResources

public protocol RingListViewModeling: ObservableObject {
	var rings: [Ring] { get }
	var currentDate: Date { get }
	var isOnboardingCardShown: Bool { get }
	
	func recordLog(for ring: Ring)
	func willEnterForeground()
}

public func ringListVM() -> some RingListViewModeling {
	RingListViewModel(dependencies: dependencies.ringList)
}

final class RingListViewModel: BaseViewModel, RingListViewModeling {
	@Published var rings: [Ring] = []
	@Published var currentDate: Date = .now
	
	var isOnboardingCardShown: Bool {
		rings.count == 1 && rings.first?.isDemo == true
	}
	
    private let dependencies: RingListDependencies

    // MARK: - Init

    init(dependencies: RingListDependencies) {
        self.dependencies = dependencies
		super.init()
		setupBindings()
	}
	
	// MARK: - Public API
	
	func recordLog(for ring: Ring) {
		do {
			try dependencies.ringsRepository.addLog(for: ring)
			
			presentToast(item: .success(L10n.General.recordRingLogToast(ring.name)))
			
			if ring.shouldCelebrateMilestone {
				presentConfettiCannon()
			}
		} catch {
			showError(error)
		}
	}
	
	func willEnterForeground() {
		currentDate = .now
	}
	
	// MARK: - Private API
	
	private func setupBindings() {
		dependencies.ringsRepository.rings()
			.assign(to: \.rings, on: self)
	}
}
