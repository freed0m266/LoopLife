//
//  SheetView.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeCore
import LoopLifeUI

import Activity
import UndefinedRoute

public struct SheetView<ViewModel: SheetViewModel>: View {
	@StateObject private var viewModel: ViewModel
	@StateObject private var router: Router = .default
	
	private let route: Route
	
	public init(viewModel: ViewModel, route: Route) {
		self._viewModel = .init(wrappedValue: viewModel)
		self.route = route
	}
	
	public var body: some View {
		NavigationStack(path: $router.sheetPath) {
			Group {
				switch route {
				case .addActivity:
					AddActivityView(viewModel: addActivityVM())
				default:
					UndefinedRouteView()
				}
			}
			.navigationDestination(for: Route.self) { screen in
				Group {
					switch screen {
					default:
						UndefinedRouteView()
					}
				}
				.withDismissButton()
			}
			.withDismissButton()
		}
	}
}

#if DEBUG
#Preview {
	SheetView(viewModel: SheetViewModel(), route: .exampleDetail(""))
		.inPreview(withSheet: true)
}
#endif
