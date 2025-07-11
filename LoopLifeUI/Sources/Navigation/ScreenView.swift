//
//  ScreenView.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct ScreenView<Content: View, Leading: View, Trailing: View>: View {
	let title: String?
	let subtitle: String?
	let padding: CGFloat
	let content: () -> Content
	let leading: () -> Leading
	let trailing: () -> Trailing
	
	@Environment(\.isTitleInline) private var isTitleInline
	
	@State private var titleViewHeight: CGFloat = 10
	@State private var isInlineVisible = false
	
	public init(
		title: String? = nil,
		subtitle: String? = nil,
		padding: CGFloat = 16,
		@ViewBuilder content: @escaping () -> Content,
		@ViewBuilder leading: @escaping () -> Leading,
		@ViewBuilder trailing: @escaping () -> Trailing
	) {
		self.title = title
		self.subtitle = subtitle
		self.padding = padding
		self.content = content
		self.leading = leading
		self.trailing = trailing
	}
	
	public var body: some View {
		ScrollViewOffset {
			VStack(spacing: 0) {
				titleView
				
				content()
					.navigationBarTitleDisplayMode(.inline)
					.toolbar {
						ToolbarItem(placement: .principal) {
							Text(title ?? "")
								.font(.headline)
								.lineLimit(1)
								.animation(.easeOut, value: isInlineVisible)
								.opacity(isTitleInline || isInlineVisible ? 1 : 0)
						}
					}
			}
			.padding([.horizontal, .bottom], padding)
		}
		.frame(maxWidth: .infinity)
		.backgroundColor(.backgroundPrimary)
		.scrollDismissesKeyboard(.interactively)
		.onPreferenceChange(OffsetPreferenceKey.self) { offset in
			guard isInlineVisible != (offset < -titleViewHeight) else {
				return
			}
			
			withAnimation {
				isInlineVisible.toggle()
			}
		}
	}
	
	@ViewBuilder private var titleView: some View {
		if let title, !isTitleInline {
			HStack(alignment: .top, spacing: 0) {
				HStack(spacing: 12) {
					leading()
					
					VStack(alignment: .leading, spacing: 4) {
						Text(title)
							.titleLarge()
							.lineLimit(3)
							.foregroundColor(.foregroundPrimary)
						
						if let subtitle {
							Text(verbatim: subtitle)
								.textMedium()
								.foregroundColor(.foregroundSecondary)
						}
					}
				}
				
				Spacer(minLength: 4)
				
				trailing()
			}
			.measureSizeOnChange(of: title) { size in
				self.titleViewHeight = size.height
			}
			.padding(.top, 4)
			.padding(.bottom, 8)
		}
	}
}

extension ScreenView where Leading == EmptyView {
	public init(
		title: String? = nil,
		subtitle: String? = nil,
		padding: CGFloat = 16,
		@ViewBuilder content: @escaping () -> Content,
		@ViewBuilder trailing: @escaping () -> Trailing
	) {
		self.title = title
		self.padding = padding
		self.content = content
		self.subtitle = subtitle
		self.leading = { EmptyView() }
		self.trailing = trailing
	}
}

extension ScreenView where Trailing == EmptyView {
	public init(
		title: String? = nil,
		subtitle: String? = nil,
		padding: CGFloat = 16,
		@ViewBuilder content: @escaping () -> Content,
		@ViewBuilder leading: @escaping () -> Leading
	) {
		self.title = title
		self.padding = padding
		self.content = content
		self.subtitle = subtitle
		self.leading = leading
		self.trailing = { EmptyView() }
	}
}

extension ScreenView where Leading == EmptyView, Trailing == EmptyView {
	public init(
		title: String? = nil,
		subtitle: String? = nil,
		padding: CGFloat = 16,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.title = title
		self.padding = padding
		self.content = content
		self.subtitle = subtitle
		self.leading = { EmptyView() }
		self.trailing = { EmptyView() }
	}
}

#if DEBUG
#Preview {
	ScreenView(title: "Title", subtitle: "Subtitle") {
		Text("content placeholder".uppercased())
			.labelLarge()
			.foregroundColor(.foregroundPrimary)
			.padding(.vertical, 200)
	} trailing: {
		Icon.info
			.size(48)
			.padding(.trailing, 8)
	}
	.inPreview()
}
#endif
