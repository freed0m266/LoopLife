//
//  Home.swift
//  ProjectDescriptionHelpers
//
//  Created by Martin Svoboda on 13.07.2025.
//

import Foundation

public let home = Feature(
	name: "Home",
	dependencies: [
		.target(name: core.name),
		.target(name: designSystem.name),
		.target(name: resources.name),
		.target(ring),
		.target(settings),
		.target(sheet),
		.target(undefinedRoute)
	],
	hasTests: false
)
