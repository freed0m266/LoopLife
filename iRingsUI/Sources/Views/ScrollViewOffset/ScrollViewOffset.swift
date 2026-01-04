//
//  ScrollViewOffset.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//
// https://github.com/FiveStarsBlog/CodeSamples/blob/main/ScrollView-Offset/ScrollViewOffset.swift

import SwiftUI

struct OffsetPreferenceKey: PreferenceKey {
	public static var defaultValue: CGFloat = .zero
	public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { }
}

struct ScrollViewOffset<Content: View>: View {
	let showsIndicators: Bool
	let content: () -> Content

	init(
		showsIndicators: Bool = true,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.showsIndicators = showsIndicators
		self.content = content
	}

	var body: some View {
		ScrollView(showsIndicators: showsIndicators) {
			offsetReader
			content()
				.padding(.top, -8)
		}
		.coordinateSpace(name: "frameLayer")
	}

	var offsetReader: some View {
		GeometryReader { proxy in
			Color.clear
				.preference(
					key: OffsetPreferenceKey.self,
					value: proxy.frame(in: .named("frameLayer")).minY
				)
		}
		.frame(height: 0)
	}
}

extension View {
	func onOffsetChanged(_ closure: @escaping (CGFloat) -> Void) -> some View {
		onPreferenceChange(OffsetPreferenceKey.self, perform: closure)
	}
}
