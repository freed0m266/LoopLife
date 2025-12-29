//
//  LinearGradient+Extensions.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public extension LinearGradient {
	static var backgroundSoft: LinearGradient {
		.init(
			colors: [
				Color(hexString: "1C1C1D"),
				Color(hexString: "242424")
			],
			startPoint: .leading,
			endPoint: .topTrailing
		)
	}
	
	static var basicRedMagenta: LinearGradient {
		.init(
			colors: [
				ColorItem.basicRed.color,
				ColorItem.basicMagenta.color
			],
			startPoint: .leading,
			endPoint: .topTrailing
//			startPoint: .topLeading,
//			endPoint: .bottomTrailing
		)
	}
}

#if DEBUG
struct LinearGradients_Previews: PreviewProvider {

	static var previews: some View {
		ScrollView {
			VStack(spacing: 16) {
				preview(of: .backgroundSoft, title: "backgroundSoft", textColor: .foregroundPrimary)
				
				preview(of: .basicRedMagenta, title: "basicRedMagenta", textColor: .foregroundPrimary)
			}
			.padding(16)
		}
		.backgroundColor(.backgroundPrimary)
	}

	static func preview(
		of linearGradient: LinearGradient,
		title: String,
		textColor: ColorItem = .foregroundOnPrimary
	) -> some View {
		RoundedRectangle(cornerRadius: 5)
			.fill(linearGradient)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.aspectRatio(2.25, contentMode: .fit)
			.overlay(alignment: .topLeading) {
				Text(title)
					.font(.system(size: 11, weight: .bold))
					.foregroundColor(textColor)
					.padding(8)
			}
			.padding(.horizontal, 8)
	}
}
#endif
