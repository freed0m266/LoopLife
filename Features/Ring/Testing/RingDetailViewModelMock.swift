//
//  RingDetailViewModelMock.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore

final class RingDetailViewModelMock: RingDetailViewModeling {
	@Published var isDeleteAlertShown = false
	@Published var isPaceInfoAlertShown = false
	
	var title: String = "Workout"
	var ring: Ring = .mock1
	var ringLogs: [RingLog] = .mock
	var vertices: [Vertex] = .mock
	
	func deleteRing() { }
	func deleteRingLog(logId: RingLog.ID) { }
}
