//
//  EntityKey.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public struct EntityKey: Hashable, Equatable {
	public let id: String
	public let entityType: String
	
	/// Empty ID is used for identification of all items with specific type
	public init(id: String = "", entityType: String) {
		self.id = id
		self.entityType = entityType
	}
}
