//
//  ActivityLog.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 12.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public struct ActivityLog: Storable {
	public let id: String
	public var date: Date
	public var completionRatio: CGFloat
	public var note: String?
	public var createdAt: Date
	public var updatedAt: Date?
}
