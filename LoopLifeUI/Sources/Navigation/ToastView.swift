//
//  ToastView.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeCore

public struct ToastView: View {
	@Binding var item: ToastItem?
	
	public init(item: Binding<ToastItem?>) {
		_item = item
	}
	
	public var body: some View {
		if let item {
			HStack(spacing: 12) {
				icon(toastType: item.type)
				
				Text(item.text)
					.labelMedium()
					.foregroundColor(.foregroundPrimary)
					.lineLimit(3)
					.multilineTextAlignment(.center)
			}
			.padding(16)
			.backgroundColor(.backgroundSecondary)
			.cornerRadius(48)
			.zIndex(1)
			.shadow(color: .black.opacity(0.16), radius: 6, x: 0, y: 2)
			.transition(.move(edge: .top))
			.padding(.horizontal, 24)
			.padding(.bottom, 50) // for pretty animation
		}
	}
	
	@ViewBuilder private func icon(toastType: ToastItem.ToastType) -> some View {
		switch toastType {
		case .loading:
			ProgressView()
				.frame(height: 24)
		case .success:
			Icon.checkmarkFill
				.foregroundColor(.basicGreen)
		case .fail:
			Icon.xmarkFill
				.foregroundColor(.basicRed)
		}
	}
}

#Preview {
	VStack(spacing: 40) {
		ToastView(item: .constant(.loading("Please wait...")))
		
		ToastView(item: .constant(.success("Success message")))
		
		ToastView(item: .constant(.failure("Unknown error")))
	}
	.padding(40)
	.backgroundColor(.backgroundPrimary)
}
