//
//  ExampleListView.swift
//  Example
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeCore
import LoopLifeUI

public struct ExampleListView<ViewModel: ExampleListViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	@StateObject private var router: Router = .default
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

    public var body: some View {
		NavigationStack(path: $router.examplePath) {
			ScreenView(title: "ExampleList") {
				EXList(headline: "Headline", items: viewModel.examples) { item in
					ListButton(title: item.text, icon: Icon.info) {
						navigateTo(route: .exampleDetail(item.id))
					}
				}
				.padding(.vertical, 16)
			}
			.navigationDestination(for: Route.self) { screen in
				switch screen {
				case .exampleDetail(let id):
					ExampleDetailView(viewModel: exampleDetailVM(id: id))
				}
			}
			.onAppear {
				setActive(path: .example)
			}
		}
    }
}

#if DEBUG
#Preview {
	ExampleListView(viewModel: ExampleListViewModelMock())
		.inPreview()
}
#endif
