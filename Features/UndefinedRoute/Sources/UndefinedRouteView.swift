//
//  UndefinedRouteView.swift
//  UndefinedRoute
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeUI

// TODO: Localize
public struct UndefinedRouteView: View {
	
	public init() { }
	
	public var body: some View {
		GeometryReader { proxy in
			ScreenView {
				VStack(spacing: 16) {
					Icon.warningTriangle
						.size(88)
						.foregroundColor(.basicOrange)
					
					Text("Something Went Wrong".uppercased())
						.titleLarge()
						.foregroundColor(.foregroundPrimary)
					
					Text("Page not found.")
						.labelLarge()
						.foregroundColor(.foregroundSecondary)
				}
				.multilineTextAlignment(.center)
				.padding(.bottom, 88)
				.frame(minHeight: proxy.size.height)
			}
		}
	}
}

#if DEBUG
#Preview {
	UndefinedRouteView()
		.inPreview()
}
#endif
