//
//  InPreview.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

struct InPreviewModifier: ViewModifier {
	let withSheet: Bool
	
	func body(content: Content) -> some View {
		NavigationStack {
			content
			
// TODO: Uncomment when Xcode fixes Preview bug (this worked fine before Xcode 16.0)
//
//			if withSheet {
//				Rectangle()
//					.fill(.clear)
//					.sheet(isPresented: .constant(true)) {
//						NavigationStack {
//							content
//								.withDismissButton()
//								.interactiveDismissDisabled()
//						}
//					}
//			} else {
//				content
//			}
		}
	}
}

/// Use it only for #Preview and snapshot testing
public extension View {
	func inPreview(withSheet: Bool = false) -> some View {
		modifier(InPreviewModifier(withSheet: withSheet))
	}
}
