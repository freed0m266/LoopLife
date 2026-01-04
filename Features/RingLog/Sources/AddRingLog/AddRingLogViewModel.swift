//
//  AddRingLogViewModel.swift
//  RingLog
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore

public protocol AddRingLogViewModeling: ObservableObject {
	var ring: Ring? { get }
	var date: Date { get set }
	
	func saveRingLog()
}

public func addRingLogVM(ringId: Ring.ID) -> some AddRingLogViewModeling {
	AddRingLogViewModel(dependencies: dependencies.addRingLog, ringId: ringId)
}

final class AddRingLogViewModel: BaseViewModel, AddRingLogViewModeling {
	@Published var ring: Ring?
	@Published var date: Date = .now
	
    private let dependencies: AddRingLogDependencies
	private let ringId: Ring.ID
	
    // MARK: - Init

	init(dependencies: AddRingLogDependencies, ringId: Ring.ID) {
        self.dependencies = dependencies
		self.ringId = ringId
		super.init()
		setupBindings()
    }
	
	// MARK: - Public API
	
	func saveRingLog() {
		do {
			guard let ring else { return }
			try dependencies.ringsRepository.addLog(for: ring, date: date)
		} catch {
			showError(error)
		}
	}
	
	// MARK: - Private API
	
	private func setupBindings() {
		dependencies.ringsRepository.ring(id: ringId)
			.map(Optional.some)
			.assign(to: \.ring, on: self)
	}
}
