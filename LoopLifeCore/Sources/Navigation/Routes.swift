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
	case sheet
}

public enum Route: Hashable {
	case exampleDetail(String)
}

extension Route: Identifiable {
	public var id: Route { self }
}
