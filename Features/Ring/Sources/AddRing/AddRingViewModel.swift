//
//  AddRingViewModel.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import LoopLifeCore

public protocol AddRingViewModeling: ObservableObject {
	var name: String? { get set }
	var targetCount: Int? { get set }
	var endDate: Date { get set }
	var isEndDateFilled: Bool { get }
	var isSaveButtonDisabled: Bool { get }
	var progressRatioText: String? { get }
	var daysRemaining: Int? { get }
	
	func saveRing()
}

public func addRingVM() -> some AddRingViewModeling {
	AddRingViewModel(dependencies: dependencies.addRing)
}

final class AddRingViewModel: BaseViewModel, AddRingViewModeling {
	@Published var name: String?
	@Published var targetCount: Int?
	@Published var endDate: Date = .now.startOfMonth
	
	var progressRatioText: String? {
		guard let targetCount else { return nil }
		return "0/\(targetCount)"
	}
	var daysRemaining: Int? {
		guard isEndDateFilled else { return nil }
		return endDate.daysRemaining()
	}
	
	var isEndDateFilled: Bool {
		.now < endDate
	}
	
	var isSaveButtonDisabled: Bool {
		name == nil || targetCount == nil || daysRemaining == nil
	}
	
    private let dependencies: AddRingDependencies
	
    // MARK: - Init

	init(dependencies: AddRingDependencies) {
        self.dependencies = dependencies
		super.init()
    }
	
	// MARK: - Public API
	
	func saveRing() {
		guard let name, let targetCount else { return }
		
		let ring = Ring(
			name: name,
			targetCount: targetCount,
			endDate: endDate
		)
		
		do {
			try dependencies.ringsRepository.save(ring: ring)
		} catch {
			showError(error)
		}
	}
}
