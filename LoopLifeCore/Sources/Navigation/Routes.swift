//
//  Routes.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public enum RoutePath {
	case example
	case home
	case sheet
}

public enum Route: Hashable {
	case addRing
	case addRingLog
	case exampleDetail(Example.ID)
	case ringDetail(Ring.ID)
}

extension Route: Identifiable {
	public var id: Route { self }
}
