//
//  EditRingViewModel.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore

public protocol EditRingViewModeling: ObservableObject {
	var name: String? { get set }
	var targetCount: Int? { get set }
	var startDate: Date { get set }
	var endDate: Date { get set }
	var isSaveButtonDisabled: Bool { get }
	
	func saveRing()
}

public func editRingVM(ringId: Ring.ID) -> some EditRingViewModeling {
	EditRingViewModel(dependencies: dependencies.editRing, ringId: ringId)
}

final class EditRingViewModel: BaseViewModel, EditRingViewModeling {
	@Published var name: String?
	@Published var targetCount: Int?
	@Published var startDate: Date = .placeholder
	@Published var endDate: Date = .placeholder
	@Published private var ring: Ring?
	
	var isSaveButtonDisabled: Bool {
		name == nil || targetCount == nil || startDate > endDate || ring == nil
	}
	
	private let dependencies: EditRingDependencies
	private let ringId: Ring.ID
	
    // MARK: - Init

	init(dependencies: EditRingDependencies, ringId: Ring.ID) {
        self.dependencies = dependencies
		self.ringId = ringId
		super.init()
		setupBindings()
    }
	
	// MARK: - Public API
	
	func saveRing() {
		guard let ring, let name, let targetCount else { return }
		
		let newRing = Ring(
			id: ring.id,
			name: name,
			targetCount: targetCount,
			startDate: startDate,
			endDate: endDate,
			lastUpdate: ring.lastUpdate,
			logIds: ring.logIds
		)
		
		do {
			try dependencies.ringsRepository.save(ring: newRing)
		} catch {
			showError(error)
		}
	}
	
	// MARK: - Private API
	
	func setupBindings() {
		dependencies.ringsRepository.ring(id: ringId)
			.map(Optional.some)
			.assign(to: \.ring, on: self)
		
		$ring
			.dropFirst()
			.receive(on: DispatchQueue.main)
			.sink { [weak self] ring in
				guard let ring else { return }
				self?.name = ring.name
				self?.targetCount = ring.targetCount
				self?.startDate = ring.startDate
				self?.endDate = ring.endDate
			}
			.store(in: &cancellables)
	}
}
