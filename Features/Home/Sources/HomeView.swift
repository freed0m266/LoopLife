//
//  HomeView.swift
//  Home
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsCore
import iRingsUI

import Ring
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
			RingListView(viewModel: viewModel.ringListViewModel)
				.navigationDestination(for: Route.self) { screen in
					switch screen {
					case let .ringDetail(id, title):
						RingDetailView(viewModel: ringDetailVM(id: id, title: title))
					default:
						UndefinedRouteView()
					}
				}
		}
		.onAppear {
			setActive(path: .home)
		}
		.toast($router.toastItem, isActive: !isSheetShown)
		.sheet(item: $router.sheetItem) { route in
			SheetView(viewModel: SheetViewModel(), route: route)
		}
	}
}

#if DEBUG
#Preview {
	HomeView(viewModel: HomeViewModel())
}
#endif
