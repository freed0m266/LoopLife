//
//  Storable.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public protocol Storable: Identifiable, Codable where ID == String {
	
}

extension Storable {
	var entityKey: EntityKey {
		.init(id: id, entityType: Self.entityType)
	}
	
	static var entityType: String {
		String(describing: self).lowercased()
	}
}
