//
//  AppError.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

public enum AppError: ErrorPresentable, Hashable {
	case general
	
	public var title: String {
		switch self {
		case .general: 
			"Error"
		}
	}
	
	public var message: String {
		switch self {
		case .general:
			"Please try again later or contact application support."
		}
	}
}

extension AppError: Equatable {
	public static func == (lhs: AppError, rhs: AppError) -> Bool {
		lhs.title == rhs.title && lhs.message == rhs.message
	}
}
