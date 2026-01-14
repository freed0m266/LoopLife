//
//  AddRingLogView.swift
//  RingLog
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsUI
import iRingsResources

public struct AddRingLogView<ViewModel: AddRingLogViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	typealias Texts = L10n.RingLog
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

    public var body: some View {
		ScreenView(
			title: Texts.addTitle,
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
			}
			.padding(.top, 16)
		}
		.hideKeyboardOnTap()
		.toolbar {
			Button(action: viewModel.saveRingLog) {
				Icon.checkmark.size(15, weight: .medium)
					.largerTapArea()
			}
		}
		.presentationDetents([.medium])
    }
}

#if DEBUG
#Preview {
	AddRingLogView(viewModel: AddRingLogViewModelMock())
		.inPreview()
}
#endif
