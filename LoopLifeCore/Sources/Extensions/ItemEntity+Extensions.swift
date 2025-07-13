//
//  ItemEntity+Extensions.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import CoreData
import BaseKitX

extension ItemEntity {
	static func fetchRequest(for key: EntityKey) -> NSFetchRequest<ItemEntity> {
		let request = fetchRequest()
		
		request.predicate = NSPredicate(format: "itemId == %@ AND type == %@", key.id, key.entityType)
		request.fetchLimit = 1
		
		return request
	}
}

extension ItemEntity {
	static func fetchRequest(ids: [String] = [], entityType: String) -> NSFetchRequest<ItemEntity> {
		let request = fetchRequest()
		
		if ids.isEmpty {
			request.predicate = NSPredicate(format: "type == %@", entityType)
		} else {
			request.predicate = NSPredicate(format: "type == %@ AND itemId IN %@", entityType, ids)
		}
		
		return request
	}
}

extension ItemEntity {
	static func batchDeleteRequest(for entityTypes: [String]? = nil) -> NSBatchDeleteRequest {
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
		
		if let entityTypes {
			request.predicate = NSCompoundPredicate.orPredicate(entityTypes: entityTypes)
		}
		
		return NSBatchDeleteRequest(fetchRequest: request)
	}
}

extension ItemEntity {
	func update<T: Storable>(with item: T) {
		do {
			let data = try item.encode()
			self.data = data
			self.changed = .now
		} catch {
			Logger.error("\(T.self): \(error)")
		}
	}
	
	func populate<T: Storable>(with item: T) {
		do {
			let data = try item.encode()
			self.data = data
			self.changed = .now
			self.created = .now
			self.itemId = item.id
			self.type = T.entityType
		} catch {
			Logger.error("\(T.self): \(error)")
		}
	}
}
