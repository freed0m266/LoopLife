//
//  Publisher+Extensions.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 12.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Combine

extension Publisher where Output: Equatable {
	func onReceiveSubscription(_ perform: @escaping (Subscription) -> Void) -> AnyPublisher<Output, Failure> {
		handleEvents(receiveSubscription: perform)
			.eraseToAnyPublisher()
	}
}
