//
//  ActivityListView.swift
//  Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeCore
import LoopLifeResources
import LoopLifeUI

public struct ActivityListView<ViewModel: ActivityListViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	typealias Texts = L10n.ActivityList
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

    public var body: some View {
		ScreenView(title: Texts.title, headline: viewModel.currentDate.dayWeekMonthFormat) {
			VStack(spacing: 16) {
				if viewModel.activities.isNotEmpty {
					ForEach(viewModel.activities) { activity in
						LLActivityCard(activity: activity) {
							viewModel.recordLog(for: activity)
						}
					}
				} else {
					placeholder
				}
			}
			.padding(.horizontal, 2)
			.padding(.vertical, 8)
		}
		.toolbar {
			Button {
				presentSheet(item: .addActivity)
			} label: {
				Icon.plus.size(17, weight: .medium)
			}
		}
		.willEnterForeground {
			viewModel.willEnterForeground()
		}
    }
	
	private var placeholder: some View {
		Button {
			presentSheet(item: .addActivity)
		} label: {
			HStack(spacing: 16) {
				ZStack {
					RingProgress(
						progress: 0.84,
						ringSize: 140,
						ringThickness: 16,
						startColor: .basicRed,
						endColor: .basicMagenta
					)
					
					RingProgress(
						progress: 0.67,
						ringSize: 104,
						ringThickness: 16,
						startColor: .mintGreen,
						endColor: .basicBlue
					)
				}
				.saturation(0)
				
				VStack(spacing: 16) {
					Text(Texts.emptyListText.uppercased())
						.titleMedium()
						.foregroundColor(.foregroundPrimary)
						.maxWidthLeading()
				}
				.multilineTextAlignment(.leading)
				.padding(.horizontal, 12)
			}
			.cardStyle()
		}
		.padding(.vertical, 8)
	}
}

#if DEBUG
#Preview {
	ActivityListView(viewModel: ActivityListViewModelMock())
		.inPreview()
}
#endif
