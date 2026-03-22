//
//  Storable.swift
//  TempooCore
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public protocol Storable: Identifiable, Equatable, Codable where ID == String {
	
}

public extension Storable {
	var entityKey: EntityKey {
		.init(id: id, entityType: Self.entityType)
	}
	
	static var entityType: String {
		String(describing: self).lowercased()
	}
}
