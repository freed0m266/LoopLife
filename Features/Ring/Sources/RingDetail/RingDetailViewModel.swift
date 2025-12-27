//
//  RingDetailViewModel.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Combine
import LoopLifeCore

public protocol RingDetailViewModeling: ObservableObject {
	var ring: Ring? { get }
	var ringLogs: [RingLog] { get }
}

public func ringDetailVM(id: Ring.ID) -> some RingDetailViewModeling {
	RingDetailViewModel(dependencies: dependencies.ringDetail, id: id)
}

final class RingDetailViewModel: BaseViewModel, RingDetailViewModeling {
	@Published var ring: Ring?
	@Published var ringLogs: [RingLog] = []
	
    private let dependencies: RingDetailDependencies
	private let id: Ring.ID
	
    // MARK: - Init

	init(dependencies: RingDetailDependencies, id: Ring.ID) {
        self.dependencies = dependencies
		self.id = id
		super.init()
		setupBindings()
    }
	
	// MARK: - Private API
	
	private func setupBindings() {
		dependencies.ringsRepository.ring(id: id)
			.map(Optional.some)
			.assign(to: \.ring, on: self)
		
		$ring
			.sink { [weak self] ring in
				guard let self, let ring else { return }

				dependencies.ringsRepository.ringLogs(ids: ring.logIds)
					.assign(to: \.ringLogs, on: self)
			}
			.store(in: &cancellables)
	}
}
