//
//  RingDetailView.swift
//  Ring
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsResources
import iRingsUI

public struct RingDetailView<ViewModel: RingDetailViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	typealias Texts = L10n.RingDetail
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}
	
	public var body: some View {
		ScreenView(title: viewModel.ring.name) {
			VStack(spacing: 40) {
				if viewModel.ring != .empty {
					ringGraph
					
					ringDates
					
					VStack(spacing: 8) {
						LLHeadline(Texts.paceIndexHeadline(viewModel.ring.paceIndexText))
						
						TimelineChart(
							vertices: viewModel.vertices,
							color: ColorItem.mintGreen.color
						)
					}
					
					ringLogs
					
					deleteButton
				}
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
					presentSheet(item: .editRing(ringId: viewModel.ring.id))
				} label: {
					Icon.sliderHorizontal
						.largerTapArea()
				}
			}
		}
		.isTitleInline()
	}
	
	private var ringGraph: some View {
		RingGraph(
			innerProps: .init(
				progress: viewModel.ring.progressRatio,
				startColor: .mintGreen,
				endColor: .basicBlue
			),
			outerProps: .init(
				progress: viewModel.ring.timeRatio,
				startColor: .basicRed,
				endColor: .basicMagenta
			),
			style: .large
		) {
			presentSheet(item: .addRingLog(ringId: viewModel.ring.id))
		}
	}
	
	private var ringDates: some View {
		VStack(spacing: 2) {
			HStack {
				Text(Texts.startDateHeadline.uppercased())
				
				Spacer()
				
				Text(Texts.endDateHeadline.uppercased())
			}
			.labelLarge()
			.foregroundColor(.basicRed)
			
			Divider()
			
			HStack {
				Text(viewModel.ring.startDate.dayMonthYearFormat)
					
				Spacer()
				
				Text(viewModel.ring.endDate.dayMonthYearFormat)
			}
			.textLarge()
			.foregroundColor(.foregroundPrimary)
		}
		.padding(.horizontal, 16)
	}
	
	private var ringLogs: some View {
		VStack(spacing: 0) {
			LLHeadline("\(Texts.recordsHeadline) (\(viewModel.ringLogs.count))")
			
			if viewModel.ringLogs.isNotEmpty {
				VStack(spacing: 0) {
					ForEach(Array(viewModel.ringLogs.enumerated()), id: \.element.id) { index, log in
						Button {
							presentSheet(item: .editRingLog(ringId: viewModel.ring.id, logId: log.id))
						} label: {
							HStack(spacing: 16) {
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
						.contextMenu {
							Button(role: .destructive) {
								viewModel.deleteRingLog(logId: log.id)
							} label: {
								Text(L10n.General.delete)
							}
						}
						
						if index != viewModel.ringLogs.count - 1 {
							Divider()
								.padding(.trailing, 20)
						}
					}
				}
				.cardStyle(verticalPadding: 0, opacity: 0.7)
			} else {
				Text(Texts.recordsEmptyTitle.uppercased())
					.titleMedium()
					.foregroundColor(.foregroundSecondary.opacity(0.5))
					.frame(maxWidth: .infinity)
					.padding(.vertical, 64)
					.cardStyle(verticalPadding: 0, opacity: 0.3)
			}
		}
	}
	
	private var deleteButton: some View {
		Button {
			viewModel.isDeleteAlertShown = true
		} label: {
			Text(Texts.deleteButton)
				.textLarge()
				.foregroundColor(.coralRed)
				.frame(maxWidth: .infinity)
				.cardStyle(opacity: 0.3)
				.padding(.vertical, 8)
		}
	}
}

#if DEBUG
#Preview {
	RingDetailView(viewModel: RingDetailViewModelMock())
		.inPreview()
}
#endif
