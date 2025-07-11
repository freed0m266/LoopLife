//
//  ConditionalAssignment.swift
//  LoopLifeCore
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation

precedencegroup ConditionalAssignmentPrecedence {
	associativity: left
	assignment: true
	higherThan: AssignmentPrecedence
}

infix operator =?: ConditionalAssignmentPrecedence

/// Set value of left-hand side only if right-hand side differs from `nil`
public func =? <T>(variable: inout T, value: T?) {
	if let v = value {
		variable = v
	}
}

/// Set value of left-hand side only if right-hand side differs from `nil`
public func =? <T>(variable: inout T?, value: T?) {
	if let v = value {
		variable = v
	}
}
