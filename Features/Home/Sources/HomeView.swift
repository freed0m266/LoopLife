//
//  HomeView.swift
//  Home
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeCore
import LoopLifeUI

import Activity
import Sheet
import UndefinedRoute

public struct HomeView<ViewModel: HomeViewModel>: View {
	@StateObject private var viewModel: ViewModel
	@StateObject private var router: Router = .default
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}
	
	public var body: some View {
		NavigationStack(path: $router.homePath) {
			ActivityListView(viewModel: viewModel.activityListViewModel)
				.navigationDestination(for: Route.self) { screen in
					switch screen {
					default:
						UndefinedRouteView()
					}
				}
		}
		.onAppear {
			setActive(path: .home)
		}
		.navigationDestination(for: Route.self) { screen in
			switch screen {
			case .activityDetail(let id):
				ActivityDetailView(viewModel: activityDetailVM(id: id))
			default:
				UndefinedRouteView()
			}
		}
	}
}

#if DEBUG
#Preview {
	HomeView(viewModel: HomeViewModel())
}
#endif
