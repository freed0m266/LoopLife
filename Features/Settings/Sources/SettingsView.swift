//
//  SettingsView.swift
//  Settings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsUI

public struct SettingsView<ViewModel: SettingsViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

	public var body: some View {
		ScreenView {
			VStack(spacing: 0) {
				
			}
		}
	}
}

#if DEBUG
#Preview {
	SettingsView(viewModel: SettingsViewModelMock())
		.inPreview()
}
#endif
