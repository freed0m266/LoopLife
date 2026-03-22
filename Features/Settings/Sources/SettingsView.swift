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
			VStack(spacing: 16) {
				appInfoCard
				
				dataManagementCard
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
		.fileExporter(
			isPresented: $viewModel.isExporting,
			document: viewModel.exportDocument,
			contentType: .json,
			defaultFilename: viewModel.exportFilename
		) { result in
			if case .success = result {
				presentToast(item: .success(Texts.exportSuccess))
			}
		}
		.fileImporter(
			isPresented: $viewModel.isImporting,
			allowedContentTypes: [.json]
		) { result in
			switch result {
			case .success(let url):
				guard url.startAccessingSecurityScopedResource() else { return }
				defer { url.stopAccessingSecurityScopedResource() }
				
				if let data = try? Data(contentsOf: url) {
					viewModel.importData(from: data)
				}
			case .failure:
				presentToast(item: .failure(Texts.importFailed))
			}
		}
		.alert(isPresented: $viewModel.isImportConfirmationShown) {
			Alert(
				title: Text(Texts.importConfirmTitle),
				message: Text(Texts.importConfirmMessage),
				primaryButton: .default(
					Text(L10n.General.yes),
					action: viewModel.confirmImport
				),
				secondaryButton: .cancel(
					Text(L10n.General.cancel)
				)
			)
		}
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
	
	private var dataManagementCard: some View {
		VStack(spacing: 0) {
			settingsButton(
				Texts.exportButton,
				icon: .squareAndArrowUp,
				action: viewModel.exportData
			)
			
			Divider()
				.padding(.vertical, 16)
				.padding(.leading, 34)
				.padding(.trailing, -16)
			
			settingsButton(
				Texts.importButton,
				icon: .squareAndArrowDown,
				action: viewModel.beginImport
			)
		}
		.cardStyle(opacity: 0.5)
	}
	
	private func settingsButton(_ title: String, icon: Icon, action: @escaping () -> Void) -> some View {
		Button(action: action) {
			HStack(spacing: 16) {
				icon
					.foregroundColor(.foregroundPrimary)
				
				Text(title)
					.textLarge()
					.foregroundColor(.foregroundPrimary)
					.maxWidthLeading()
				
				Icon.chevronRight
					.size(12)
					.foregroundColor(.iconPrimary)
			}
		}
	}
}

#if DEBUG
#Preview {
	SettingsView(viewModel: SettingsViewModelMock())
		.inPreview()
}
#endif
