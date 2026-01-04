//
//  RingCard.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 25.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsResources

public struct RingCard: View {
	
	let name: String?
	let daysRemaining: Int?
	let progressRatioText: String?
	let timeRatio: Double?
	let progressRatio: Double?
	let action: (() -> Void)?
	
	private var categoryText: String {
		guard let name, name.isNotEmpty else { return "..." }
		return name.uppercased()
	}
	
	private var deadlineText: String {
		guard let daysRemaining else { return "..." }
		return Texts.deadlineValue(daysRemaining).uppercased()
	}
	
	private var goalText: String {
		guard let progressRatioText else { return "..." }
		return Texts.goalValue(progressRatioText).uppercased()
	}
	
	typealias Texts = L10n.RingCard
	
	public init(
		name: String? = nil,
		daysRemaining: Int? = nil,
		progressRatioText: String? = nil,
		timeRatio: Double? = nil,
		progressRatio: Double? = nil,
		action: (() -> Void)? = nil
	) {
		self.name = name
		self.daysRemaining = daysRemaining
		self.progressRatioText = progressRatioText
		self.timeRatio = timeRatio
		self.progressRatio = progressRatio
		self.action = action
	}
	
	public var body: some View {
		HStack(spacing: 24) {
			rings
			
			VStack(alignment: .leading, spacing: 12) {
				infoTextBlock(
					headline: Texts.categoryHeadline,
					value: categoryText,
					color: name == nil ? .foregroundDisabled.opacity(0.5) : .skyBlue
				)
				
				infoTextBlock(
					headline: Texts.deadlineHeadline,
					value: deadlineText,
					color: daysRemaining == nil ? .foregroundDisabled.opacity(0.5) : .basicRed
				)
				
				infoTextBlock(
					headline: Texts.goalHeadline,
					value: goalText,
					color: progressRatioText == nil ? .foregroundDisabled.opacity(0.5) : .mintGreen
				)
			}
			.maxWidthLeading()
		}
		.padding(16)
	}
	
	private var rings: some View {
		ZStack {
			RingProgress(
				progress: timeRatio ?? 0.75,
				ringSize: 140,
				ringThickness: 16,
				startColor: .basicRed,
				endColor: .basicMagenta
			)
			.saturation(daysRemaining == nil ? 0 : 1)
			
			RingProgress(
				progress: progressRatio ?? 0.5,
				ringSize: 104,
				ringThickness: 16,
				startColor: .mintGreen,
				endColor: .basicBlue
			)
			.saturation(progressRatioText == nil ? 0 : 1)
			
			if let action {
				Button(action: action) {
					Icon.plus
						.padding(26)
						.backgroundColor(.iconPrimary.opacity(0.01))
						.clipShape(.circle)
				}
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
				.animation(.default, value: progressRatio)
				.contentTransition(.numericText())
		}
	}
}

#if DEBUG
#Preview {
	VStack(spacing: 16) {
		RingCard()
			.background {
				LinearGradient.backgroundSoft
			}
			.cornerRadius(16)
		
		RingCard(
			name: "Workout",
			daysRemaining: 26,
			progressRatioText: "6/10",
			timeRatio: 0.7,
			progressRatio: 0.6,
			action: { }
		)
		.background {
			LinearGradient.backgroundSoft
		}
		.cornerRadius(16)
	}
	.padding(16)
	.frame(maxWidth: .infinity, maxHeight: .infinity)
	.backgroundColor(.backgroundPrimary)
}
#endif
