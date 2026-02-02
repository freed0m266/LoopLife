//
//  RingListView.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsCore
import iRingsResources
import iRingsUI

public struct RingListView<ViewModel: RingListViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	typealias Texts = L10n.RingList
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

    public var body: some View {
		ScreenView(title: Texts.title, headline: viewModel.currentDate.dayWeekMonthFormat) {
			VStack(spacing: 16) {
				if viewModel.rings.isNotEmpty {
					ForEach(viewModel.rings) { ring in
						RingDashboard(ring: ring) {
							viewModel.recordLog(for: ring)
						}
					}
					
					onboardingCard
				} else {
					emptyListCard
				}
			}
			.padding(.horizontal, 2)
			.padding(.vertical, 8)
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					presentSheet(item: .addRing)
				} label: {
					Icon.plus
						.foregroundStyle(.white)
				}
				.buttonStyle(.glassProminent)
			}
			
			#if DEBUG
			ToolbarItem(placement: .topBarTrailing) {
				Button {
					navigateTo(route: .settings)
				} label: {
					Icon.gearshape
				}
			}
			#endif
		}
		.willEnterForeground {
			viewModel.willEnterForeground()
		}
    }
	
	@ViewBuilder private var onboardingCard: some View {
		if viewModel.isOnboardingCardShown {
			VStack(alignment: .leading, spacing: 16) {
				Text(Texts.onboardingHeadline)
					.labelLarge()
					.foregroundColor(.foregroundSecondary)
				
				Text(Texts.onboardingText)
					.textLarge()
			}
			.foregroundColor(.foregroundSecondary)
			.maxWidthLeading()
			.multilineTextAlignment(.leading)
			.padding(.trailing, 32)
			.cardStyle(opacity: 0.5)
			.padding(.vertical, 8)
		}
	}
	
	private var emptyListCard: some View {
		VStack(alignment: .center, spacing: 0) {
			Icon.circleDashed
				.size(80)
				.padding(.bottom, 24)
			
			Text(Texts.emptyListTitle)
				.titleMedium()
				.padding(.bottom, 16)
			
			Text(Texts.emptyListText)
				.textLarge()
		}
		.foregroundColor(.foregroundSecondary)
		.frame(maxWidth: .infinity)
		.multilineTextAlignment(.center)
		.padding(.vertical, 8)
		.padding(.horizontal, 16)
		.cardStyle(opacity: 0.5)
		.padding(.vertical, 8)
	}
}

#if DEBUG
#Preview {
	RingListView(viewModel: RingListViewModelMock())
		.inPreview()
}
#endif
