//
//  ExampleListView.swift
//  Example
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeUI

public struct ExampleListView<ViewModel: ExampleListViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

    public var body: some View {
		ScreenView(title: "ExampleList") {
			LLList(headline: "Headline", items: viewModel.examples) { item in
				ListButton(title: item.text, icon: Icon.info) {
					navigateTo(route: .exampleDetail(exampleId: item.id))
				}
			}
			.padding(.vertical, 16)
		}
    }
}

#if DEBUG
#Preview {
	ExampleListView(viewModel: ExampleListViewModelMock())
		.inPreview()
}
#endif
