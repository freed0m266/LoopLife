//
//  RingProgress.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import MKRingProgressView

public struct RingProgress: View {
	@State var currentProgress: Double = 0
	
	let progress: Double
	let ringSize: CGFloat
	let ringThickness: CGFloat
	let startColor: ColorItem
	let endColor: ColorItem
	
	public init(
		progress: Double,
		ringSize: CGFloat,
		ringThickness: CGFloat = 25,
		startColor: ColorItem,
		endColor: ColorItem
	) {
		self.progress = progress
		self.ringThickness = ringThickness
		self.ringSize = ringSize
		self.startColor = startColor
		self.endColor = endColor
	}
	
	public var body: some View {
		UIRingProgress(
			progress: currentProgress,
			ringWidth: ringThickness,
			startColor: startColor.uiColor,
			endColor: endColor.uiColor
		)
		.frame(width: ringSize, height: ringSize)
		.onAppear {
			currentProgress = progress
		}
		.onChange(of: progress) {
			currentProgress = progress
		}
	}
}

#if DEBUG
#Preview {
	ZStack {
		RingProgress(progress: 0.26, ringSize: 183, startColor: .skyBlue, endColor: .electricPurple)
		
		RingProgress(progress: 0.72, ringSize: 240, startColor: .basicRed, endColor: .basicMagenta)
	}
	.frame(maxWidth: .infinity, maxHeight: .infinity)
	.backgroundColor(.backgroundPrimary)
}
#endif

private struct UIRingProgress: UIViewRepresentable {
	private let startColor: UIColor
	private let endColor: UIColor
	private let ringWidth: CGFloat
	private let progress: Double
	
	init(progress: Double, ringWidth: CGFloat, startColor: UIColor, endColor: UIColor) {
		self.startColor = startColor
		self.endColor = endColor
		self.ringWidth = ringWidth
		self.progress = progress
	}
	
	func makeUIView(context: Context) -> RingProgressView {
		let ring = RingProgressView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
		ring.progress = progress
		ring.ringWidth = ringWidth
		ring.startColor = startColor
		ring.endColor = endColor
		ring.shadowOpacity = 0.5
		return ring
	}
	
	func updateUIView(_ uiView: RingProgressView, context: Context) {
		UIView.animate(
			withDuration: 1.0 + progress,
			delay: 0,
			usingSpringWithDamping: 0.8,
			initialSpringVelocity: 0,
			options: .curveEaseOut
		) {
			uiView.progress = progress
		}
	}
}
