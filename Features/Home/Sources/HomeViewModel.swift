//
//  HomeViewModel.swift
//  Home
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import LoopLifeCore
import Activity

public final class HomeViewModel: BaseViewModel, ObservableObject {
	let activityListViewModel: some ActivityListViewModeling = activityListVM()
}
