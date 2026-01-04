//
//  NSCompoundPredicate+Extensions.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import CoreData

extension NSCompoundPredicate {
	static func orPredicate(entityTypes: [String]) -> NSCompoundPredicate {
		var predicates: [NSPredicate] = []
		
		entityTypes.forEach { type in
			predicates.append(NSPredicate(format: "type == %@", type))
		}
		
		return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
	}
}
