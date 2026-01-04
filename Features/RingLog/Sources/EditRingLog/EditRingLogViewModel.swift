//
//  EditRingLogViewModel.swift
//  RingLog
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore

public protocol EditRingLogViewModeling: ObservableObject {
	var ring: Ring? { get }
	var date: Date { get set }
	var isEditButtonDisabled: Bool { get }
	
	func editRingLog()
}

public func editRingLogVM(ringId: Ring.ID, logId: RingLog.ID) -> some EditRingLogViewModeling {
	EditRingLogViewModel(dependencies: dependencies.editRingLog, ringId: ringId, logId: logId)
}

final class EditRingLogViewModel: BaseViewModel, EditRingLogViewModeling {
	@Published var ring: Ring?
	@Published var date: Date = .now
	@Published var isEditButtonDisabled = true
	
	@Published private var ringLog: RingLog?
	
    private let dependencies: EditRingLogDependencies
	private let ringId: Ring.ID
	private let logId: RingLog.ID
	
    // MARK: - Init

	init(
		dependencies: EditRingLogDependencies,
		ringId: Ring.ID,
		logId: RingLog.ID
	) {
        self.dependencies = dependencies
		self.ringId = ringId
		self.logId = logId
		super.init()
		setupBindings()
    }
	
	// MARK: - Public API
	
	func editRingLog() {
		do {
			guard let ringLog else { return }
			try dependencies.ringsRepository.editLog(log: ringLog, date: date)
			
			// Refresh logs on ring's detail
			_ = dependencies.ringsRepository.ring(id: ringId)
		} catch {
			showError(error)
		}
	}
	
	// MARK: - Private API
	
	private func setupBindings() {
		dependencies.ringsRepository.ring(id: ringId)
			.map(Optional.some)
			.assign(to: \.ring, on: self)
		
		dependencies.ringsRepository.ringLog(id: logId)
			.map(Optional.some)
			.assign(to: \.ringLog, on: self)
		
		$ringLog
			.receive(on: DispatchQueue.main)
			.sink { [weak self] log in
				guard let log else { return }
				self?.date = log.date
			}
			.store(in: &cancellables)
		
		$date
			.dropFirst(2)
			.receive(on: DispatchQueue.main)
			.sink { [weak self] _ in
				self?.isEditButtonDisabled = false
			}
			.store(in: &cancellables)
	}
}
