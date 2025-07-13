//
//  ActivityListView.swift
//  Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeCore
import LoopLifeUI

public struct ActivityListView<ViewModel: ActivityListViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

    public var body: some View {
		ScreenView {
			
		}
    }
}

#if DEBUG
#Preview {
	ActivityListView(viewModel: ActivityListViewModelMock())
		.inPreview()
}
#endif
