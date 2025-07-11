//
//  Image+Extensions.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

extension Image {
	public func size(_ size: CGFloat) -> some View {
		resizable()
			.frame(width: size, height: size)
	}
}
