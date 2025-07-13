//
//  AppViewModel.swift
//  LoopLife
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import LoopLifeCore
import Home

final class AppViewModel: BaseViewModel, ObservableObject {
	
	lazy var homeViewModel = HomeViewModel()
	
	// MARK: - Init
	
	override init() {
		super.init()
		setupBindings()
	}
	
	// MARK: - Private API
	
	private func setupBindings() {
		
	}
}
