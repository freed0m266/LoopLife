//
//  RingGraph.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct RingGraph: View {
	public struct Props {
		let progress: Double
		let startColor: ColorItem
		let endColor: ColorItem
		
		public init(
			progress: Double,
			startColor: ColorItem,
			endColor: ColorItem
		) {
			self.progress = progress
			self.startColor = startColor
			self.endColor = endColor
		}
	}
	
	public enum Style {
		case small
		case large
		
		var innerSize: CGFloat {
			switch self {
			case .small: 104
			case .large: 183
			}
		}
		
		var outerSize: CGFloat {
			switch self {
			case .small: 140
			case .large: 241
			}
		}
		
		var thickness: CGFloat {
			switch self {
			case .small: 16
			case .large: 25
			}
		}
		
		var buttonSize: CGFloat {
			switch self {
			case .small: 17
			case .large: 36
			}
		}
		
		var buttonPadding: CGFloat {
			switch self {
			case .small: 26
			case .large: 24
			}
		}
	}
	
	let innerProps: Props
	let outerProps: Props
	let style: Style
	let action: (() -> Void)?
	
	public init(
		innerProps: Props,
		outerProps: Props,
		style: Style,
		action: (() -> Void)? = nil
	) {
		self.innerProps = innerProps
		self.outerProps = outerProps
		self.style = style
		self.action = action
	}
	
	public var body: some View {
		ZStack {
			RingProgress(
				progress: innerProps.progress,
				ringSize: style.innerSize,
				ringThickness: style.thickness,
				startColor: innerProps.startColor,
				endColor: innerProps.endColor
			)
			
			RingProgress(
				progress: outerProps.progress,
				ringSize: style.outerSize,
				ringThickness: style.thickness,
				startColor: outerProps.startColor,
				endColor: outerProps.endColor
			)
			
			if let action {
				Button(action: action) {
					Icon.plus
						.size(style.buttonSize)
						.padding(style.buttonPadding)
						.backgroundColor(.iconPrimary.opacity(0.01))
						.clipShape(.circle)
				}
			}
		}
    }
}

#Preview {
	VStack(spacing: 64) {
		RingGraph(
			innerProps: .init(
				progress: 0.67,
				startColor: .mintGreen,
				endColor: .basicBlue
			),
			outerProps: .init(
				progress: 0.84,
				startColor: .basicRed,
				endColor: .basicMagenta
			),
			style: .small
		) {
			
		}
		
		RingGraph(
			innerProps: .init(
				progress: 0.67,
				startColor: .mintGreen,
				endColor: .basicBlue
			),
			outerProps: .init(
				progress: 0.84,
				startColor: .basicRed,
				endColor: .basicMagenta
			),
			style: .large
		)
	}
}
