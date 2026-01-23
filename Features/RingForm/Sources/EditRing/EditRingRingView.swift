//
//  EditRingView.swift
//	RingForm
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsUI
import iRingsResources

public struct EditRingView<ViewModel: EditRingViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	typealias Texts = L10n.RingForm
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

    public var body: some View {
		ScreenView(
			title: Texts.editTitle,
			backgroundColor: .backgroundSecondary
		) {
			VStack(spacing: 8) {
				LLTextField(
					headline: Texts.categoryHeadline,
					text: $viewModel.name,
					placeholder: Texts.categoryPlaceholder
				)
				
				VStack(spacing: 0) {
					LLHeadline(Texts.scheduleHeadline)
					
					VStack(spacing: 8) {
						DatePicker(
							Texts.startDateHeadline,
							selection: $viewModel.startDate,
							components: .date,
							to: .now
						)
						
						Divider()
						
						DatePicker(
							Texts.endDateHeadline,
							selection: $viewModel.endDate,
							components: .date,
							from: .now
						)
					}
					.titleLarge()
					.padding(.vertical, 12)
					.padding(.horizontal, 16)
					.background {
						LinearGradient.backgroundSoft
					}
					.cornerRadius(16)
				}
				
				LLNumberField(
					headline: Texts.goalHeadline,
					number: $viewModel.targetCount,
					placeholder: Texts.goalPlaceholder
				)
			}
		}
		.isTitleInline()
		.hideKeyboardOnTap()
		.toolbar {
			Button {
				viewModel.saveRing()
				closeSheet()
			} label: {
				Icon.checkmark.size(15, weight: .medium)
					.largerTapArea()
			}
			.disabled(viewModel.isSaveButtonDisabled)
		}
		.presentationDetents([.medium])
    }
}

#if DEBUG
#Preview {
	EditRingView(viewModel: EditRingViewModelMock())
		.inPreview()
}
#endif
