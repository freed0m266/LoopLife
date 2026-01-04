//
//  DateMock.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import BaseKitX

public extension Date {
	/// 1. 1. 2000
	static var mock2000: Date {
		.fromComponents(year: 2000, month: 1, day: 1)
	}
	
	/// 5. 12. 2003, 9:55
	static var mock2003: Date {
		.fromComponents(year: 2003, month: 12, day: 5, hour: 9, minute: 55)
	}
	
	/// 12. 7. 2021, 17:38
	static var mock2021: Date {
		.fromComponents(year: 2021, month: 7, day: 12, hour: 17, minute: 38)
	}
	
	/// 15. 11. 2022, 16:45
	static var mock2022: Date {
		.fromComponents(year: 2022, month: 11, day: 15, hour: 16, minute: 45)
	}
	
	/// 2. 3. 2023, 7:21
	static var mock2023: Date {
		.fromComponents(year: 2023, month: 3, day: 2, hour: 7, minute: 21)
	}
	
	/// 16. 8. 2024, 14:10
	static var mock2024: Date {
		.fromComponents(year: 2024, month: 8, day: 16, hour: 14, minute: 10)
	}
	
	/// 22. 3. 2026, 9:00
	static var mock2026: Date {
		.fromComponents(year: 2026, month: 3, day: 22, hour: 9)
	}
	
	/// 12. 10. 2028, 12:30
	static var mock2028: Date {
		.fromComponents(year: 2028, month: 10, day: 12, hour: 12, minute: 30)
	}
	
	/// 26. 6. 2077, 6:30
	static var mock2077: Date {
		.fromComponents(year: 2077, month: 6, day: 26, hour: 6, minute: 30)
	}
}
