//
//  UserStorage.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 30.01.2026.
//  Copyright © 2026 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserStorage<T: Codable> {
	private let key: UserStorageKey
	private let defaultValue: T
	private let store: UserDefaults
	
	init(wrappedValue: T, _ key: UserStorageKey, store: UserDefaults = .standard) {
		self.key = key
		self.defaultValue = wrappedValue
		self.store = store
	}
	
	var wrappedValue: T {
		get {
			do {
				guard let data = store.data(forKey: key.rawValue) else {
					return defaultValue
				}
				return try T.decode(from: data)
			} catch {
				Logger.error(error)
				return defaultValue
			}
		}
		set {
			do {
				let data = try newValue.encode()
				store.set(data, forKey: key.rawValue)
			} catch {
				Logger.error(error)
			}
		}
	}
}

public enum UserStorageKey: String, CaseIterable {
	case wasDemoRingEverCreated
}
