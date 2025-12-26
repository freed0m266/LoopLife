//
//  AddRingView.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeCore
import LoopLifeUI
import LoopLifeResources

public struct AddRingView<ViewModel: AddRingViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	typealias Texts = L10n.AddRing
	
	var deadlinePickerText: String {
		guard let days = viewModel.daysRemaining else { return Texts.deadlinePlaceholder }
		return days > 1 ? Texts.deadlineValuePlural(days) : Texts.deadlineValueSingular(days)
	}
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

    public var body: some View {
		ScreenView(title: Texts.title) {
			VStack(spacing: 8) {
				RingCard(
					name: viewModel.name,
					daysRemaining: viewModel.daysRemaining,
					progressRatioText: viewModel.progressRatioText,
				)
				.animation(.default, value: viewModel.name)
				.animation(.default, value: viewModel.endDate)
				.animation(.default, value: viewModel.targetCount)
				.background {
					LinearGradient.backgroundSoft
				}
				.cornerRadius(16)
				.padding(.bottom, 16)
				
				LLTextField(
					headline: Texts.categoryHeadline,
					text: $viewModel.name,
					textColor: .skyBlue,
					placeholder: Texts.categoryPlaceholder
				)
				
				LLDatePicker(
					headline: Texts.deadlineHeadline,
					date: $viewModel.endDate,
					text: deadlinePickerText,
					textColor: viewModel.isEndDateFilled ? .basicMagenta : .foregroundPlaceholder
				)
				
				LLNumberField(
					headline: Texts.goalHeadline,
					number: $viewModel.targetCount,
					numberColor: .mintGreen,
					placeholder: Texts.goalPlaceholder
				)
			}
			.padding(.top, 8)
		}
		.hideKeyboardOnTap()
		.toolbar {
			Button {
				viewModel.saveRing()
				closeSheet()
			} label: {
				Icon.checkmark.size(15, weight: .medium)
			}
			.disabled(viewModel.isSaveButtonDisabled)
		}
    }
}

#if DEBUG
#Preview {
	AddRingView(viewModel: AddRingViewModelMock())
		.inPreview()
}
#endif
