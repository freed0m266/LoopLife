//
//  EditRingLogView.swift
//  RingLog
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsUI
import iRingsResources

public struct EditRingLogView<ViewModel: EditRingLogViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	typealias Texts = L10n.RingLog
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

    public var body: some View {
		ScreenView(
			title: Texts.editTitle,
			subtitle: viewModel.ring?.name,
			backgroundColor: .backgroundSecondary
		) {
			VStack(spacing: 16) {
				LLDatePicker(
					date: $viewModel.date,
					components: .date,
					title: Texts.dateText,
					titleColor: .foregroundPrimary,
					to: .now
				)
				
				LLDatePicker(
					date: $viewModel.date,
					components: .hourAndMinute,
					title: Texts.timeText,
					titleColor: .foregroundPrimary
				)
				
				LLTextEditor(
					Texts.notePlaceholder,
					text: $viewModel.note
				)
			}
			.padding(.top, 16)
		}
		.hideKeyboardOnTap()
		.toolbar {
			ToolbarItem(placement: .confirmationAction) {
				Button {
					viewModel.editRingLog()
					closeSheet()
				} label: {
					Icon.checkmark.size(15, weight: .medium)
				}
				.disabled(viewModel.isEditButtonDisabled)
			}
		}
		.toolbar {
			if viewModel.isKeyboardVisible {
				Icon.keyboardChevronDown.size(15, weight: .medium)
					.foregroundColor(.mintGreen)
					.padding(.leading, 8)
					.hideKeyboardOnTap()
			}
		}
		.keyboardResponder { isVisible in
			viewModel.isKeyboardVisible = isVisible
		}
		.presentationDetents([.medium, .large])
    }
}

#if DEBUG
#Preview {
	EditRingLogView(viewModel: EditRingLogViewModelMock())
		.inPreview()
}
#endif
