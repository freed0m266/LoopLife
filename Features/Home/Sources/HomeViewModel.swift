//
//  HomeViewModel.swift
//  Home
//
//  Created by Martin Svoboda on 13.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore
import Ring

public final class HomeViewModel: BaseViewModel, ObservableObject {
	let ringListViewModel: some RingListViewModeling = ringListVM()
}
