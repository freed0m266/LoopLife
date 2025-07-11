//
//  ToastItem.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct ToastItem {
	public let text: String
	public let type: ToastType
	
	public init(text: String, type: ToastType) {
		self.text = text
		self.type = type
	}
}

public extension ToastItem {
	enum ToastType {
		case loading
		case success
		case fail
	}
	
	static func loading(_ message: String) -> ToastItem {
		.init(text: message, type: .loading)
	}
	
	static func success(_ message: String) -> ToastItem {
		.init(text: message, type: .success)
	}
	
	static func failure(_ message: String) -> ToastItem {
		.init(text: message, type: .fail)
	}
}

extension ToastItem: Equatable {
	public static func == (lhs: ToastItem, rhs: ToastItem) -> Bool {
		lhs.text == rhs.text && lhs.type == rhs.type
	}
}
