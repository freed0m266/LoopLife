//
//  Haptics.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 13.01.2026.
//  Copyright © 2026 Freedom Martin, s.r.o. All rights reserved.
//

import UIKit

public enum HapticType {
	case success
	case fail
}

final class Haptics: ObservableObject {
	static let `default` = Haptics()
	
	// MARK: - Internal API
	
	static func hapticFeedback(type: HapticType?) {
		switch type {
		case .success:
			Haptics.default.feedbackSuccess()
		case .fail:
			Haptics.default.feedbackFailure()
		case .none:
			break
		}
	}
	
	// MARK: - Private API
	
	private func feedbackSuccess() {
		let generator = UINotificationFeedbackGenerator()
		generator.notificationOccurred(.success)
	}
	
	private func feedbackFailure() {
		let generator = UINotificationFeedbackGenerator()
		generator.notificationOccurred(.error)
	}
}
