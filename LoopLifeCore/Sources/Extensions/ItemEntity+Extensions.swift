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
		
		let predicates: [NSPredicate] = [
			NSPredicate(format: "itemId == %@", key.id),
			NSPredicate(format: "type == %@", key.entityType)
		]
		
		request.fetchLimit = 1
		request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
		return request
	}
}

extension ItemEntity {
	static func fetchRequest(for entityType: String) -> NSFetchRequest<ItemEntity> {
		let request = fetchRequest()
		
		request.predicate = NSPredicate(format: "type == %@", entityType)
		return request
	}
	
	static func fetchRequest(for ids: [String], of entityType: String) -> NSFetchRequest<ItemEntity> {
		let request = fetchRequest()
		
		request.predicate = NSCompoundPredicate(
			andPredicateWithSubpredicates: [
				NSCompoundPredicate.orPredicate(ids: ids),
				NSPredicate(format: "type == %@", entityType)
			]
		)
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
	func update<T: Storable>(with element: T) {
		do {
			let data = try element.encode()
			self.data = data
			self.changed = .now
		} catch {
			Logger.error("\(T.self): \(error)")
		}
	}
	
	func populate<T: Storable>(with element: T) {
		do {
			let data = try element.encode()
			self.data = data
			self.changed = .now
			self.created = .now
			self.itemId = element.id
			self.type = T.entityType
		} catch {
			Logger.error("\(T.self): \(error)")
		}
	}
}
