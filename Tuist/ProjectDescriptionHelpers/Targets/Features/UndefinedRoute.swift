//
//  UndefinedRoute.swift
//  ProjectDescriptionHelpers
//
//  Created by Martin Svoboda on 13.07.2025.
//

import Foundation

public let undefinedRoute = Feature(
	name: "UndefinedRoute",
	dependencies: [
		.target(name: core.name),
		.target(name: designSystem.name),
		.target(name: resources.name)
	],
	hasTests: true,
	hasTesting: false
)
