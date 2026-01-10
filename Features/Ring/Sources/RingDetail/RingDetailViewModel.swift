//
//  RingDetailViewModel.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Combine
import iRingsCore

import Foundation

public protocol RingDetailViewModeling: ObservableObject {
	var ring: Ring { get }
	var ringLogs: [RingLog] { get }
	var isDeleteAlertShown: Bool { get set }
	
	func deleteRing()
	func deleteRingLog(logId: RingLog.ID)
}

public func ringDetailVM(id: Ring.ID) -> some RingDetailViewModeling {
	RingDetailViewModel(dependencies: dependencies.ringDetail, id: id)
}

final class RingDetailViewModel: BaseViewModel, RingDetailViewModeling {
	@Published var ring: Ring = .empty
	@Published var ringLogs: [RingLog] = []
	@Published var isDeleteAlertShown = false
	
    private let dependencies: RingDetailDependencies
	private let id: Ring.ID
	
    // MARK: - Init

	init(dependencies: RingDetailDependencies, id: Ring.ID) {
        self.dependencies = dependencies
		self.id = id
		super.init()
		setupBindings()
    }
	
	// MARK: - Public API

	func deleteRing() {
		do {
			try dependencies.ringsRepository.deleteRing(id: id, logIds: ring.logIds)
			navigateBack()
		} catch {
			showError(error)
		}
	}
	
	func deleteRingLog(logId: RingLog.ID) {
		do {
			try dependencies.ringsRepository.deleteLog(for: ring, logId: logId)
		} catch {
			showError(error)
		}
	}
	
	// MARK: - Private API
	
	private func setupBindings() {
		dependencies.ringsRepository.ring(id: id)
			.assign(to: \.ring, on: self)
		
		$ring
			.sink { [weak self] ring in
				guard let self, ring.logIds.isNotEmpty else { return }

				dependencies.ringsRepository.ringLogs(ids: ring.logIds)
					.map { $0.sortedBy(\.date, descending: true) }
					.assign(to: \.ringLogs, on: self)
			}
			.store(in: &cancellables)
		
//		$ringLogs
//			.sink { [weak self] ringLogs in
//				guard let self, let ring else { return }
//				
//				let targetCount = ring.targetCount
//				let startDate = ring.startDate
//				let daysTotal = ring.daysTotal
//				
//				var vertices: [Vertex] = []
//				
//				ringLogs.enumerated().forEach { index, log in
//					let progressRatio = Double(ringLogs.count - index) / Double(targetCount)
//					
//					let daysElapsed = Double(startDate.daysElapsed(until: log.date))
//					let timeRatio = Double(daysElapsed) / Double(daysTotal)
//					
//					let vertex = Vertex(
//						x: daysElapsed,
//						y: progressRatio / timeRatio
//					)
//					vertices.append(vertex)
//				}
//			}
//			.store(in: &cancellables)
	}
}
