//
//  LLActivityCard.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeCore
import LoopLifeResources

public struct LLActivityCard: View {
	let activity: Activity
	let action: () -> Void
	
	typealias Texts = L10n.ActivityCard
	
	public init(
		activity: Activity,
		action: @escaping () -> Void
	) {
		self.activity = activity
		self.action = action
	}
	
	public var body: some View {
		Button {
			navigateTo(route: .activityDetail(activity.id))
		} label: {
			VStack(spacing: 0) {
				title
				
				divider
				
				HStack(spacing: 24) {
					rings
					
					VStack(alignment: .leading, spacing: 12) {
						infoTextBlock(
							headline: Texts.categoryHeadline,
							value: activity.category.name.uppercased(),
							color: .skyBlue
						)
						
						infoTextBlock(
							headline: Texts.deadlineHeadline,
							value: Texts.deadlineValue(activity.daysRemaining).uppercased(),
							color: .basicRed
						)
						
						infoTextBlock(
							headline: Texts.goalHeadline,
							value: Texts.goalValue(activity.progressRatioText).uppercased(),
							color: .mintGreen
						)
					}
					.maxWidthLeading()
				}
				.padding(16)
			}
			.background {
				LinearGradient.backgroundSoft
			}
			.cornerRadius(16)
		}
		.buttonStyle(.plain)
	}
	
	private var title: some View {
		Text(activity.title)
			.labelLarge()
			.foregroundColor(.foregroundPrimary)
			.padding(.horizontal, 12)
			.padding(.vertical, 8)
			.maxWidthLeading()
	}
	
	private var divider: some View {
		Rectangle()
			.foregroundColor(.backgroundSecondary)
			.frame(height: 0.5)
	}
	
	private var rings: some View {
		ZStack {
			RingProgress(
				progress: activity.timeRatio,
				ringSize: 140,
				ringThickness: 16,
				startColor: .basicRed,
				endColor: .basicMagenta
			)
			
			RingProgress(
				progress: activity.progressRatio,
				ringSize: 104,
				ringThickness: 16,
				startColor: .mintGreen,
				endColor: .basicBlue
			)
			
			Button(action: action) {
				Icon.plus
					.padding(26)
					.backgroundColor(.iconPrimary.opacity(0.01))
					.clipShape(.circle)
			}
		}
	}
	
	private func infoTextBlock(headline: String, value: String, color: ColorItem) -> some View {
		VStack(alignment: .leading, spacing: 0) {
			Text(headline)
				.labelMedium()
				.foregroundColor(.foregroundPrimary)
			
			Text(value)
				.labelLarge()
				.foregroundColor(color)
		}
	}
}

#if DEBUG
#Preview {
	VStack(spacing: 16) {
		LLActivityCard(activity: .mock1) { }
		
		LLActivityCard(activity: .mock2) { }
		
		LLActivityCard(activity: .mock3) { }
	}
	.padding(16)
	.frame(maxWidth: .infinity, maxHeight: .infinity)
	.backgroundColor(.backgroundPrimary)
}
#endif
