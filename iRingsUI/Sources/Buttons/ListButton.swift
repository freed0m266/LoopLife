//
//  ListButton.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct ListButton: View {
	@Environment(\.isEnabled) private var isEnabled
	
	let title: String
	let icon: Icon?
	let iconColor: ColorItem?
	let action: () -> Void
	
	public init(
		title: String,
		icon: Icon,
		iconColor: ColorItem? = nil,
		action: @escaping () -> Void
	) {
		self.title = title
		self.icon = icon
		self.iconColor = iconColor
		self.action = action
	}
	
	public init(
		title: String,
		action: @escaping () -> Void
	) {
		self.title = title
		self.icon = nil
		self.iconColor = nil
		self.action = action
	}
	
	public var body: some View {
		Button(action: action) {
			HStack(spacing: 16) {
				icon?
					.foregroundColor(iconColor ?? .iconPrimary)
				
				Text(title)
					.textLarge()
					.foregroundColor(.foregroundPrimary)
					.maxWidthLeading()
				
				Icon.chevronRight
					.size(12, weight: .semibold)
					.foregroundColor(.iconPrimary)
					.padding(.trailing, 4)
			}
			.frame(minHeight: 24)
			.padding(12)
			.backgroundColor(.backgroundSecondary)
		}
		.buttonStyle(ListButtonStyle())
	}
}

#if DEBUG
#Preview {
	VStack(spacing: 16) {
		ListButton(title: "title", icon: Icon.info) {
			
		}
		.cornerRadius(10)
		
		ListButton(title: "title", icon: Icon.checkmarkFill, iconColor: .basicGreen) {
			
		}
		.cornerRadius(10)
		
		ListButton(title: "title", icon: Icon.xmarkFill) {
			
		}
		.cornerRadius(10)
		.disabled(true)
	}
	.padding(16)
	.backgroundColor(.backgroundPrimary)
}
#endif
