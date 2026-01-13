//
//  DatePicker+Extensions.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 13.01.2026.
//  Copyright © 2026 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public extension DatePicker where Label == Text {
	init<S>(
		_ title: S = "",
		selection: Binding<Date>,
		components: DatePicker<Label>.Components,
		from: Date? = nil,
		to: Date? = nil
	) where S : StringProtocol {
		if let from, let to {
			self = DatePicker(
				title,
				selection: selection,
				in: ClosedRange<Date>(uncheckedBounds: (lower: from, upper: to)),
				displayedComponents: components
			)
		} else if let from {
			self = DatePicker(
				title,
				selection: selection,
				in: PartialRangeFrom<Date>(from),
				displayedComponents: components
			)
		} else if let to {
			self = DatePicker(
				title,
				selection: selection,
				in: PartialRangeThrough<Date>(to),
				displayedComponents: components
			)
		} else {
			self = DatePicker(
				title,
				selection: selection,
				displayedComponents: components
			)
		}
	}
}
