//
//  AppView.swift
//  LoopLife
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeUI
import Home

struct AppView<ViewModel: AppViewModel>: View {
	@ObservedObject var viewModel: ViewModel

	var body: some View {
		HomeView(viewModel: viewModel.homeViewModel)
			.tint(.mintGreen)
	}
}
