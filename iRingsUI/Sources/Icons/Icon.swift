//
//  Icon.swift
//  iRingsUI
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
	/// arrow.trianglehead.clockwise
	static var arrowClockwise: Icon = "arrow.trianglehead.clockwise"
	/// checkmark
	static var checkmark: Icon = "checkmark"
	/// checkmark.circle.fill
	static var checkmarkFill: Icon = "checkmark.circle.fill"
	/// chevron.right
	static var chevronRight: Icon = "chevron.right"
	/// circle.circle
	static var circleCircle: Icon = "circle.circle"
	/// clock.arrow.circlepath
	static var clockArrowCirclepath: Icon = "clock.arrow.circlepath"
	/// doc.on.doc
	static var copy: Icon = "doc.on.doc"
	/// gearshape
	static var gearshape: Icon = "gearshape"
	/// info.circle
	static var info: Icon = "info.circle"
	/// keyboard.chevron.compact.down
	static var keyboardChevronDown: Icon = "keyboard.chevron.compact.down"
	/// plus
	static var plus: Icon = "plus"
	/// plus.circle
	static var plusCircle: Icon = "plus.circle"
	/// plus.circle.fill
	static var plusCircleFill: Icon = "plus.circle.fill"
	/// record.circle
	static var recordCircle: Icon = "record.circle"
	/// record.circle.fill
	static var recordCircleFill: Icon = "record.circle.fill"
	/// slider.horizontal.3
	static var sliderHorizontal: Icon = "slider.horizontal.3"
	/// trash
	static var trash: Icon = "trash"
	/// exclamationmark.triangle
	static var warningTriangle: Icon = "exclamationmark.triangle"
	/// xmark
	static var xmark: Icon = "xmark"
	/// xmark.circle.fill
	static var xmarkFill: Icon = "xmark.circle.fill"
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
