//
//  Icon.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct Icon: View {
	private let name: String
	
	public var body: some View {
		image
	}
}

private extension Icon {
	var image: Image { .init(systemName: name) }
}

extension Icon: ExpressibleByStringLiteral {
	public init(stringLiteral value: StaticString) {
		self.name = "\(value)"
	}
}

public extension Icon {
	func size(_ size: CGFloat, weight: Font.Weight? = nil) -> some View {
		image
			.font(.system(size: size, weight: weight))
	}
}

public extension Icon {
	/// checkmark.circle.fill
	static var checkmarkFill: Icon = "checkmark.circle.fill"
	/// xmark.circle.fill
	static var xmarkFill: Icon = "xmark.circle.fill"
	/// chevron.right
	static var chevronRight: Icon = "chevron.right"
	/// info.circle
	static var info: Icon = "info.circle"
	/// doc.on.doc
	static var copy: Icon = "doc.on.doc"
}

#Preview {
	VStack(spacing: 40) {
		Icon.checkmarkFill
			.size(24)
			.foregroundColor(.basicGreen)
		
		Icon.xmarkFill
			.size(24)
			.foregroundColor(.basicRed)
		
		Icon.copy
			.size(24)
			.foregroundColor(.basicBlue)
	}
	.frame(maxWidth: 300, maxHeight: 300)
	.padding(16)
	.backgroundColor(.backgroundPrimary)
}
