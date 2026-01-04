//
//  RoundedCorner.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

struct RoundedCorner: Shape {
	let radius: CGFloat
	let corners: UIRectCorner

	func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(
			roundedRect: rect,
			byRoundingCorners: corners,
			cornerRadii: CGSize(
				width: radius,
				height: radius
			)
		)
		
		return Path(path.cgPath)
	}
}

public extension View {
	func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
		clipShape(RoundedCorner(radius: radius, corners: corners))
	}
}
