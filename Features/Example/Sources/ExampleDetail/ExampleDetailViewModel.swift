//
//  ExampleDetailViewModel.swift
//  Example
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Combine
import iRingsCore

public protocol ExampleDetailViewModeling: ObservableObject {
	var example: Example { get }
}

public func exampleDetailVM(id: Example.ID) -> some ExampleDetailViewModeling {
	ExampleDetailViewModel(dependencies: dependencies.exampleDetail, id: id)
}

final class ExampleDetailViewModel: BaseViewModel, ExampleDetailViewModeling {
	@Published var example: Example = .mock1
	
    private let dependencies: ExampleDetailDependencies
	private let id: Example.ID
	
    // MARK: - Init

	init(dependencies: ExampleDetailDependencies, id: Example.ID) {
        self.dependencies = dependencies
		self.id = id
		super.init()
		setupBindings()
    }
	
	// MARK: - Private API
	
	private func setupBindings() {
		
	}
}
