//
//  SettingsView.swift
//  Settings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsUI
import iRingsResources

public struct SettingsView<ViewModel: SettingsViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	typealias Texts = L10n.Settings
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

	public var body: some View {
		ScreenView(title: Texts.title) {
			VStack(spacing: 0) {
				appInfoCard
			}
			.padding(.vertical, 16)
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				ShareLink(item: viewModel.appUrl) {
					Icon.squareAndArrowUp
						.padding(.bottom, 4)
				}
			}
		}
		.isTitleInline()
	}
	
	private var appInfoCard: some View {
		HStack(spacing: 16) {
			Assets.appIcon.swiftUIImage
				.size(50)
				.cornerRadius(10)
				.overlay {
					RoundedRectangle(cornerRadius: 10)
						.stroke(.basicBlack, lineWidth: 0.5)
						.aspectRatio(1, contentMode: .fit)
				}
			
			VStack(alignment: .leading, spacing: 8) {
				Text(Texts.appName(viewModel.version))
					.labelLarge()
					.foregroundColor(.foregroundPrimary)
					
				Text(Texts.appAuthor)
					.labelMedium()
					.foregroundColor(.foregroundSecondary)
			}
			.maxWidthLeading()
		}
		.cardStyle(opacity: 0.5)
	}
}

#if DEBUG
#Preview {
	SettingsView(viewModel: SettingsViewModelMock())
		.inPreview()
}
#endif
