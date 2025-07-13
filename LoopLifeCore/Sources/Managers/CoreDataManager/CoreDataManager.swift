//
//  CoreDataManager.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import CoreData
import Foundation

public protocol CoreDataManaging {
	func save<T: Storable>(item: T) throws
	func saveAll<T: Storable>(items: [T]) throws
	func load<T: Storable>(id: T.ID) throws -> T?
	func loadAll<T: Storable>() throws -> [T]
	func delete(key: EntityKey) throws
	func delete(ids: [String], entityType: String) throws
}

final class CoreDataManager: CoreDataManaging {
	
	private var itemContext: NSManagedObjectContext
	
	private var container: NSPersistentContainer = {
		// swiftlint:disable:next force_unwrapping
		let url = Bundle(for: CoreDataManager.self).url(forResource: "Local", withExtension: "momd")!
		// swiftlint:disable:next force_unwrapping
		let model = NSManagedObjectModel(contentsOf: url)!
		
		let result = NSPersistentContainer(name: "Local", managedObjectModel: model)
		
		result.loadPersistentStores { _, error in
			if let error {
				Logger.error(error)
			}
		}
		return result
	}()
	
	// MARK: - Init
	
	init() {
		itemContext = container.newBackgroundContext()
	}
	
	// MARK: - Public API
	
	func save<T: Storable>(item: T) throws {
		try itemContext.performAndWait {
			do {
				/// Make request for the saving item
				let key = item.entityKey
				let request = ItemEntity.fetchRequest(for: key)
				
				if let entity = try itemContext.fetch(request).first {
					entity.update(with: item)
				} else {
					let entity = ItemEntity(context: itemContext)
					entity.populate(with: item)
				}
				
				try saveItemContext()
			} catch {
				Logger.error(error)
				throw error
			}
		}
	}
	
	func saveAll<T: Storable>(items: [T]) throws {
		guard !items.isEmpty else { return }
		
		try itemContext.performAndWait {
			do {
				/// Make request for the saving items
				let request = ItemEntity.fetchRequest(entityType: T.entityType)
				
				/// Load existing entities
				let entities = try itemContext.fetch(request)
				
				items.forEach { item in
					if let entity = entities.first(where: { $0.itemId == item.id }) {
						entity.update(with: item)
					} else {
						let entity = ItemEntity(context: itemContext)
						entity.populate(with: item)
					}
				}
				
				try saveItemContext()
			} catch {
				Logger.error(error)
				throw error
			}
		}
	}
	
	func load<T: Storable>(id: T.ID) throws -> T? {
		/// Make request for the loading item
		let entityKey = EntityKey(id: id, entityType: T.entityType)
		let request = ItemEntity.fetchRequest(for: entityKey)
		var item: T?
		
		try itemContext.performAndWait {
			do {
				/// Fetch entity and return just the item
				guard let entity = try itemContext.fetch(request).first else { return }
				item = try decode(entity: entity)
			} catch {
				Logger.error(error)
				throw error
			}
		}
		
		return item
	}
	
	func loadAll<T: Storable>() throws -> [T] {
		/// Make request for all items with specific type
		let request = ItemEntity.fetchRequest(entityType: T.entityType)
		var items: [T] = []
		
		try itemContext.performAndWait {
			do {
				/// Fetch entities and return just the items
				let entities = try itemContext.fetch(request)
				
				try entities.forEach { entity in
					guard let item: T = try decode(entity: entity) else { return }
					items.append(item)
				}
			} catch {
				Logger.error(error)
				throw error
			}
		}
		
		return items
	}
	
	func delete(key: EntityKey) throws {
		let itemRequest = ItemEntity.fetchRequest(for: key)
		
		/// Delete entity
		try itemContext.performAndWait {
			do {
				if let entity = try itemContext.fetch(itemRequest).first {
					itemContext.delete(entity)
					try saveItemContext()
				}
			} catch {
				Logger.error(error)
				throw error
			}
		}
	}
	
	func delete(ids: [String], entityType: String) throws {
		let itemsRequest = ItemEntity.fetchRequest(ids: ids, entityType: entityType)
		
		/// Delete entities
		try itemContext.performAndWait { [weak self] in
			guard let context = self?.itemContext else { return }
			
			do {
				let entities = try context.fetch(itemsRequest)
				for entity in entities {
					context.delete(entity)
				}
				try self?.saveItemContext()
			} catch {
				Logger.error(error)
				throw error
			}
		}
	}
	
	// MARK: - Private API
	
	private func decode<T: Storable>(entity: ItemEntity) throws -> T? {
		guard let id = entity.itemId, let data = entity.data else {
			Logger.error("Failed to decode entity: Missing required attributes")
			return nil
		}
		
		do {
			let item = try T.decode(from: data)
			return item
		} catch {
			/// Remove the invalid or corrupted entity
			try delete(key: .init(id: id, entityType: T.entityType))
			throw error
		}
	}
	
	private func saveItemContext() throws {
		if itemContext.hasChanges {
			try itemContext.save()
		}
	}
}
