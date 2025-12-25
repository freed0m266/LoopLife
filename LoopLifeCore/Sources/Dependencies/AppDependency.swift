//
//  AppDependency.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public final class AppDependency: ObservableObject {
	
	lazy var coreDataManager: CoreDataManaging = CoreDataManager()
	
	public lazy var ringsRepository: RingsRepositoring = RingsRepository(coreDataManager: coreDataManager)
	
	// MARK: - Init
	
	init() { }
}

public let dependencies = AppDependency()
