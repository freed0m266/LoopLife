//
//  PrimaryButton.swift
//  iRingsCore
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct PrimaryButton<Content: View>: View {
	let foreground: ColorItem
	let background: ColorItem
	let cornerRadius: CGFloat
	let isArrowShown: Bool
	let action: (() -> Void)?
	let asyncAction: (() async -> Void)?
	let label: () -> Content
	
	@State var isLoading = false
	
	public init(
		foreground: ColorItem,
		background: ColorItem,
		cornerRadius: CGFloat = 10,
		isArrowShown: Bool = false,
		action: @escaping () -> Void,
		@ViewBuilder label: @escaping () -> Content
	) {
		self.foreground = foreground
		self.background = background
		self.cornerRadius = cornerRadius
		self.isArrowShown = isArrowShown
		self.action = action
		self.label = label
		self.asyncAction = nil
	}
	
	public init(
		foreground: ColorItem,
		background: ColorItem,
		cornerRadius: CGFloat = 10,
		isArrowShown: Bool = false,
		asyncAction: @escaping () async -> Void,
		@ViewBuilder label: @escaping () -> Content
	) {
		self.foreground = foreground
		self.background = background
		self.cornerRadius = cornerRadius
		self.isArrowShown = isArrowShown
		self.asyncAction = asyncAction
		self.label = label
		self.action = nil
	}
	
	public var body: some View {
		Button {
			if let action {
				action()
			} else {
				guard !isLoading else { return }
				Task {
					isLoading = true
					await asyncAction?()
					isLoading = false
				}
			}
		} label: {
			if isLoading {
				ProgressView()
					.tint(foreground)
					.frame(maxWidth: .infinity)
			} else {
				label()
					.overlay(alignment: .trailing) {
						if isArrowShown {
							Icon.chevronRight
								.size(12, weight: .semibold)
								.padding(.trailing, 4)
						}
					}
			}
		}
		.buttonStyle(PrimaryButtonStyle(foreground: foreground, background: background, cornerRadius: 24))
	}
}

#if DEBUG
fileprivate extension PrimaryButton {
	init(
		foreground: ColorItem,
		background: ColorItem,
		cornerRadius: CGFloat = 10,
		isArrowShown: Bool = false,
		isLoading: Bool = false,
		@ViewBuilder label: @escaping () -> Content
	) {
		self.foreground = foreground
		self.background = background
		self.cornerRadius = cornerRadius
		self.isArrowShown = isArrowShown
		self.label = label
		self.isLoading = isLoading
		self.action = nil
		self.asyncAction = nil
	}
}

#Preview {
	VStack(spacing: 20) {
		PrimaryButton(foreground: .basicWhite, background: .basicBlue) {
			Text("Label")
				.labelLarge()
				.frame(maxWidth: .infinity)
		}
		
		PrimaryButton(foreground: .basicWhite, background: .basicBlue) {
			Text("Label")
				.labelLarge()
				.frame(maxWidth: .infinity)
		}
		.disabled(true)

		PrimaryButton(foreground: .basicBlue, background: .pastelBlue, isArrowShown: true) {
			HStack(spacing: 16) {
				Icon.copy
				
				Text("Settings")
					.labelLarge()
					.maxWidthLeading()
			}
		}

		PrimaryButton(foreground: .basicBlue, background: .pastelBlue) {
			HStack(spacing: 16) {
				Icon.copy
				
				Text("Copy ")
					.labelLarge()
					.maxWidthLeading()
			}
		}
	}
	.padding(16)
	.backgroundColor(.backgroundPrimary)
}
#endif
