//
//  AppError.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import LoopLifeResources

public enum AppError: ErrorPresentable, Equatable, Hashable {
	case general(message: String)
	
	public var title: String {
		L10n.Error.defaultTitle
	}
	
	public var message: String {
		localizedDescription
	}
	
	public init (message: String) {
		self = .general(message: message)
	}
}
