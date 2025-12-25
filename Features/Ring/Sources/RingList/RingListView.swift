//
//  RingListView.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeCore
import LoopLifeResources
import LoopLifeUI

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
					
					placeholder
				} else {
					placeholder
				}
			}
			.padding(.horizontal, 2)
			.padding(.vertical, 8)
		}
		.toolbar {
			Button {
				presentSheet(item: .addRing)
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
			presentSheet(item: .addRing)
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
	RingListView(viewModel: RingListViewModelMock())
		.inPreview()
}
#endif
