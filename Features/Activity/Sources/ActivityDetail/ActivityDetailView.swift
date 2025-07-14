//
//  ActivityDetailView.swift
//  Activity
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeResources
import LoopLifeUI

public struct ActivityDetailView<ViewModel: ActivityDetailViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	typealias Texts = L10n.ActivityDetail
	
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
	ActivityDetailView(viewModel: ActivityDetailViewModelMock())
		.inPreview()
}
#endif
