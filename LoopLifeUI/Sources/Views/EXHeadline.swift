//
//  Headline.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct EXHeadline: View {
	let text: String
	
	public init(_ text: String) {
		self.text = text
	}
	
	public var body: some View {
		Text(text.uppercased())
			.headline()
			.foregroundColor(.foregroundSecondary)
			.padding(.horizontal, 16)
			.padding(.vertical, 8)
			.maxWidthLeading()
	}
}

#if DEBUG
#Preview {
	EXHeadline("headline")
		.padding(16)
		.backgroundColor(.backgroundPrimary)
}
#endif
