//
//  RingDashboard.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsCore
import iRingsResources

public struct RingDashboard: View {
	let ring: Ring
	let action: () -> Void
	
	private var lastUpdateText: String {
		guard let lastUpdate = ring.lastUpdate else { return Texts.lastUpdateEmpty }
		
		if lastUpdate.isToday {
			return Texts.lastUpdateToday
		} else if lastUpdate.isYesterday {
			return Texts.lastUpdateYesterday
		} else {
			return Texts.lastUpdate(lastUpdate.daysElapsed())
		}
	}
	
	typealias Texts = L10n.RingCard
	
	public init(
		ring: Ring,
		action: @escaping () -> Void
	) {
		self.ring = ring
		self.action = action
	}
	
	public var body: some View {
		Button {
			navigateTo(route: .ringDetail(ringId: ring.id, title: ring.name))
		} label: {
			VStack(spacing: 0) {
				lastUpdate
				
				divider
				
				RingCard(
					name: ring.name,
					daysRemaining: ring.daysRemaining,
					progressRatioText: ring.progressRatioText,
					timeRatio: ring.timeRatio,
					progressRatio: ring.progressRatio,
					action: action
				)
			}
			.background {
				LinearGradient.backgroundSoft
			}
			.cornerRadius(16)
		}
		.buttonStyle(.plain)
	}
	
	private var lastUpdate: some View {
		HStack(spacing: 8) {
			Icon.clockArrowCirclepath
				.size(14, weight: .medium)
			
			Text(lastUpdateText)
				.labelMedium()
				.maxWidthLeading()
				.animation(.default, value: ring.lastUpdate)
				.contentTransition(.numericText())
		}
		.foregroundColor(.foregroundSecondary)
		.padding(.horizontal, 12)
		.padding(.vertical, 8)
	}
	
	private var divider: some View {
		Rectangle()
			.foregroundColor(.backgroundTertiary)
			.frame(height: 0.5)
	}
}

#if DEBUG
#Preview {
	VStack(spacing: 16) {
		RingDashboard(ring: .mock1) { }
		
		RingDashboard(ring: .mock2) { }
		
		RingDashboard(ring: .mock3) { }
	}
	.padding(16)
	.frame(maxWidth: .infinity, maxHeight: .infinity)
	.backgroundColor(.backgroundPrimary)
}
#endif
