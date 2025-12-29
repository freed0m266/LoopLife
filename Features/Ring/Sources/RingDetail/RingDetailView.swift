//
//  RingDetailView.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeResources
import LoopLifeUI

public struct RingDetailView<ViewModel: RingDetailViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	typealias Texts = L10n.RingDetail
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}
	
	public var body: some View {
		ScreenView(title: viewModel.ring?.name) {
			VStack(spacing: 40) {
				if let ring = viewModel.ring {
					RingGraph(
						innerProps: .init(
							progress: ring.progressRatio,
							startColor: .mintGreen,
							endColor: .basicBlue
						),
						outerProps: .init(
							progress: ring.timeRatio,
							startColor: .basicRed,
							endColor: .basicMagenta
						),
						style: .large
					) {
						presentSheet(item: .addRingLog(ring.id))
					}
					
					VStack(spacing: 8) {
						HStack {
							Text(Texts.startDateHeadline.uppercased())
								.labelLarge()
								.foregroundColor(.foregroundSecondary)
								.maxWidthLeading()
							
							Text(ring.startDate.dayMonthYearFormat)
								.textLarge()
								.foregroundColor(.foregroundPrimary)
						}
						
						Divider()
						
						HStack {
							Text(Texts.endDateHeadline.uppercased())
								.labelLarge()
								.foregroundColor(.foregroundSecondary)
								.maxWidthLeading()
							
							Text(ring.endDate.dayMonthYearFormat)
								.textLarge()
								.foregroundColor(.foregroundPrimary)
						}
					}
					.padding(.horizontal, 16)
				}
				
				ringLogs
			}
			.alert(isPresented: $viewModel.isDeleteAlertShown) {
				Alert(
					title: Text(Texts.deleteAlertTitle),
					message: Text(Texts.deleteAlertMessage),
					primaryButton: .destructive(
						Text(Texts.deleteAlertButton),
						action: viewModel.deleteRing)
					,
					secondaryButton: .cancel(
						Text(L10n.General.cancel)
					)
				)
			}
			.toolbar {
				Button {
					viewModel.isDeleteAlertShown = true
				} label: {
					Icon.trash.size(17)
						.foregroundColor(.foregroundPrimary)
				}
			}
		}
		.isTitleInline()
	}
	
	@ViewBuilder private var ringLogs: some View {
		if viewModel.ringLogs.isNotEmpty {
			VStack(spacing: 0) {
				LLHeadline(Texts.allRecordsHeadline)
				
				VStack(spacing: 0) {
					ForEach(Array(viewModel.ringLogs.enumerated()), id: \.element.id) { index, log in
						Button {
							presentSheet(item: .editRingLog(log.id))
						} label: {
							HStack(spacing: 16) {
								Text((viewModel.ringLogs.count - index).description)
									.labelMedium()
									.foregroundColor(.foregroundPlaceholder)
								
								Text(log.date.dayMonthYearFormat)
									.foregroundColor(.foregroundPrimary)
									.maxWidthLeading()
								
								Text(log.date.hourMinuteFormat)
									.foregroundColor(.foregroundSecondary)
									
								Icon.chevronRight
									.size(12)
									.foregroundColor(.foregroundSecondary)
							}
							.padding(.vertical, 12)
							.backgroundColor(.backgroundPrimary.opacity(0.01)) // Tap area
						}
						.buttonStyle(.plain)
						
						if index != viewModel.ringLogs.count - 1 {
							Divider()
								.padding(.leading, 20)
								.padding(.trailing, 20)
						}
					}
				}
				.cardStyle(verticalPadding: 0, opacity: 0.7)
			}
		}
		
	}
}

#if DEBUG
#Preview {
	RingDetailView(viewModel: RingDetailViewModelMock())
		.inPreview()
}
#endif
