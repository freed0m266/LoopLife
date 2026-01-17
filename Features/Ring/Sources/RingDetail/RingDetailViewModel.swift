//
//  RingDetailViewModel.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Combine
import Foundation
import iRingsCore

public protocol RingDetailViewModeling: ObservableObject {
	var title: String { get }
	var ring: Ring { get }
	var ringLogs: [RingLog] { get }
	var vertices: [Vertex] { get }
	var isDeleteAlertShown: Bool { get set }
	var isPaceInfoAlertShown: Bool { get set }
	
	func deleteRing()
	func deleteRingLog(logId: RingLog.ID)
}

public func ringDetailVM(id: Ring.ID, title: String) -> some RingDetailViewModeling {
	RingDetailViewModel(dependencies: dependencies.ringDetail, id: id, title: title)
}

final class RingDetailViewModel: BaseViewModel, RingDetailViewModeling {
	@Published var ring: Ring = .empty
	@Published var ringLogs: [RingLog] = []
	@Published var vertices: [Vertex] = []
	@Published var isDeleteAlertShown = false
	@Published var isPaceInfoAlertShown = false
	
    private let dependencies: RingDetailDependencies
	private let id: Ring.ID
	let title: String
	
    // MARK: - Init

	init(dependencies: RingDetailDependencies, id: Ring.ID, title: String) {
        self.dependencies = dependencies
		self.id = id
		self.title = title
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
		
		$ringLogs
			.dropFirst()
			.sink { [weak self] ringLogs in
				self?.setupVertices(ringLogs: ringLogs)
			}
			.store(in: &cancellables)
	}
	
	private func setupVertices(ringLogs: [RingLog]) {
		let targetCount = ring.targetCount
		let startDate = ring.startDate
		let daysTotal = ring.daysTotal
		
		let startToday = Date.now.startOfDay
		let twoWeeksAgo = startToday.plus(days: -13)
		var vertices: [Vertex] = []
		
		ringLogs.enumerated().forEach { index, log in
			guard log.date > twoWeeksAgo else { return }
			
			let progressRatio = Double(ringLogs.count - index) / Double(targetCount)
			let daysElapsed = log.date.days(from: startDate)
			let timeRatio = daysElapsed / Double(daysTotal)
			
			let vertex = Vertex(
				date: log.date,
				value: progressRatio / timeRatio * 100
			)
			vertices.append(vertex)
		}
		
		let firstVertex = {
			let progressRatio = Double(ringLogs.count - vertices.count) / Double(targetCount)
			let timeRatio = twoWeeksAgo.days(from: startDate) / Double(daysTotal)
			let value = progressRatio / timeRatio * 100
			
			return Vertex(
				date: max(startDate, twoWeeksAgo),
				value: value.isNaN ? 0 : value
			)
		}()
		vertices.append(firstVertex)
		
		let lastVertex = {
			let endToday = startToday.plus(days: 1)
			let daysElapsed = endToday.days(from: startDate)
			let timeRatio = daysElapsed / Double(daysTotal)
			
			return Vertex(
				date: endToday,
				value: ring.progressRatio / timeRatio * 100
			)
		}()
		vertices.append(lastVertex)
		
		vertices = vertices.sorted()
		DispatchQueue.main.async { [weak self] in
			self?.vertices = vertices
		}
	}
}
