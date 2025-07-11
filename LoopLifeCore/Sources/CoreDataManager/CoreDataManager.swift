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
	func save<T: Storable>(element: T)
	func saveAll<T: Storable>(elements: [T])
	func load<T: Storable>(id: T.ID) -> T?
	func loadAll<T: Storable>() -> [T]?
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
	
	func save<T: Storable>(element: T) {
		itemContext.performAndWait { [weak self] in
			do {
				guard let context = self?.itemContext else { return }
				
				/// Make request for the saving item
				let key = element.entityKey
				let request = ItemEntity.fetchRequest(for: key)
				
				if let item = try context.fetch(request).first {
					item.update(with: element)
				} else {
					let item = ItemEntity(context: context)
					item.populate(with: element)
				}
				
				try self?.saveItemContext()
			} catch {
				Logger.error(error)
			}
		}
	}
	
	func saveAll<T: Storable>(elements: [T]) {
		guard !elements.isEmpty else { return }
		
		itemContext.performAndWait { [weak self] in
			do {
				guard let context = self?.itemContext else { return }
				
				/// Make request for the saving items
				let request = ItemEntity.fetchRequest(for: T.entityType)
				
				/// Load existing entities
				let items = try context.fetch(request)
				
				elements.forEach { element in
					if let item = items.first(where: { $0.itemId == element.id }) {
						item.update(with: element)
					} else {
						let item = ItemEntity(context: context)
						item.populate(with: element)
					}
				}
				
				try self?.saveItemContext()
			} catch {
				Logger.error(error)
			}
		}
	}
	
	func load<T: Storable>(id: T.ID) -> T? {
		/// Make request for the loading item
		let entityKey = EntityKey(id: id, entityType: T.entityType)
		let request = ItemEntity.fetchRequest(for: entityKey)
		var entity: T?
		
		itemContext.performAndWait { [weak self] in
			do {
				/// Fetch item and return just the entity
				guard let item = try self?.itemContext.fetch(request).first else { return }
				entity = try self?.decode(item: item)
			} catch {
				Logger.error(error)
			}
		}
		
		return entity
	}
	
	func loadAll<T: Storable>() -> [T]? {
		/// Make request for all item with the specific type
		let request = ItemEntity.fetchRequest(for: T.entityType)
		var entities: [T]?
		
		itemContext.performAndWait { [weak self] in
			do {
				/// Fetch items and return just the entities
				let items = try self?.itemContext.fetch(request)
				
				entities = []
				items?.forEach { item in
					guard let entity: T = try? self?.decode(item: item) else { return }
					entities?.append(entity)
				}
			} catch {
				Logger.error(error)
			}
		}
		
		return entities
	}
	
	func delete(key: EntityKey) throws {
		let itemRequest = ItemEntity.fetchRequest(for: key)
		
		/// Delete the item
		try itemContext.performAndWait { [weak self] in
			guard let context = self?.itemContext else { return }
			
			do {
				if let item = try context.fetch(itemRequest).first {
					context.delete(item)
					try self?.saveItemContext()
				}
			} catch {
				Logger.error(error)
				throw error
			}
		}
	}
	
	func delete(ids: [String], entityType: String) throws {
		let itemsRequest = ItemEntity.fetchRequest(for: ids, of: entityType)
		
		/// Delete items
		try itemContext.performAndWait { [weak self] in
			guard let context = self?.itemContext else { return }
			
			do {
				let items = try context.fetch(itemsRequest)
				for item in items {
					context.delete(item)
				}
				try self?.saveItemContext()
			} catch {
				Logger.error(error)
				throw error
			}
		}
	}
	
	// MARK: - Private API
	
	private func decode<T: Storable>(item: ItemEntity) throws -> T? {
		guard let id = item.itemId, let data = item.data else { return nil }
		
		do {
			let entity = try T.decode(from: data)
			return entity
		} catch {
			/// Remove the invalid or corrupted cached item
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
