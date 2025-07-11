//
//  EXList.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeCore

public struct EXList<T, ID>: View where ID: Hashable {
	let headline: String?
	let items: [T]
	let id: KeyPath<T, ID>
	let content: (T) -> ListButton

	public init(
		headline: String? = nil,
		items: [T],
		id: KeyPath<T, ID>,
		content: @escaping (T) -> ListButton
	) {
		self.headline = headline
		self.items = items
		self.id = id
		self.content = content
	}
	
	public var body: some View {
		VStack(spacing: 0) {
			if let headline {
				EXHeadline(headline)
			}
			
			LazyVStack(spacing: 0) {
				ForEach(items, id: id) { item in
					content(item)
						.listDivider(isShown: item[keyPath: id] != items.last?[keyPath: id])
				}
			}
			.cornerRadius(10)
		}
	}
}
	
extension EXList where ID == T.ID, T: Identifiable {
	public init(
		headline: String? = nil,
		items: [T],
		content: @escaping (T) -> ListButton
	) {
		self.headline = headline
		self.items = items
		self.id = \.id
		self.content = content
	}
}

#if DEBUG
#Preview {
	VStack(spacing: 16) {
		EXList(headline: "headline", items: [Example].mock) { example in
			ListButton(title: example.text) {
				
			}
		}
	}
	.padding(16)
	.backgroundColor(.backgroundPrimary)
}
#endif
