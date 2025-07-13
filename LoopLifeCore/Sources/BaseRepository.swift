//
//  BaseRepository.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import Combine

open class BaseRepository {
	
	private let coreDataManager: CoreDataManaging
	
	// MARK: - Init
	
	init(coreDataManager: CoreDataManaging) {
		self.coreDataManager = coreDataManager
	}
	
	// MARK: - Public API
	
	func loadItems<T: Storable>(subject: inout PassthroughSubject<[T], Error>) {
		do {
			let items: [T] = try coreDataManager.loadAll()
			subject.send(items)
		} catch {
			Logger.error("\(T.entityType) | \(error)")
			subject.send(completion: .failure(error))
		}
	}
	
	func loadItem<T: Storable>(id: T.ID, subject: inout PassthroughSubject<T, Error>) {
		do {
			if let item: T = try coreDataManager.load(id: id) {
				subject.send(item)
			}
		} catch {
			Logger.error("\(T.entityType)(\(id)) | \(error)")
			subject.send(completion: .failure(error))
		}
	}
	
	func createItem<T: Storable>(item: T) throws {
		try coreDataManager.save(item: item)
	}
	
	func deleteItem(id: String, entityType: String) throws {
		let key = EntityKey(id: id, entityType: entityType)
		try coreDataManager.delete(key: key)
	}
}
