//
//  ExampleListViewModel.swift
//  Example
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Combine
import iRingsCore

public protocol ExampleListViewModeling: ObservableObject {
	var examples: [Example] { get }
}

public func exampleListVM() -> some ExampleListViewModeling {
	ExampleListViewModel(dependencies: dependencies.exampleList)
}

final class ExampleListViewModel: BaseViewModel, ExampleListViewModeling {
	@Published var examples: [Example] = .mock
	
    private let dependencies: ExampleListDependencies

    // MARK: - Init

    init(dependencies: ExampleListDependencies) {
        self.dependencies = dependencies
		super.init()
		setupBindings()
	}
	
	// MARK: - Private API
	
	private func setupBindings() {

	}
}
