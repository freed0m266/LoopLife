//
//  EditRingLogView.swift
//  RingLog
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeUI
import LoopLifeResources

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
					dateComponents: .date,
					text: Texts.dateText,
					textColor: .foregroundPrimary
				)
				
				LLDatePicker(
					date: $viewModel.date,
					dateComponents: .hourAndMinute,
					text: Texts.timeText,
					textColor: .foregroundPrimary
				)
			}
			.padding(.top, 16)
		}
		.hideKeyboardOnTap()
		.toolbar {
			Button {
				viewModel.editRingLog()
				closeSheet()
			} label: {
				Icon.checkmark.size(15, weight: .medium)
			}
			.disabled(viewModel.isEditButtonDisabled)
		}
		.presentationDetents([.medium])
    }
}

#if DEBUG
#Preview {
	EditRingLogView(viewModel: EditRingLogViewModelMock())
		.inPreview()
}
#endif
