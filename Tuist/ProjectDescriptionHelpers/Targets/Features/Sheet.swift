//
//  Sheet.swift
//  ProjectDescriptionHelpers
//
//  Created by Martin Svoboda on 03.07.2025.
//

import Foundation

public let sheet = Feature(
	name: "Sheet",
	dependencies: [
		.target(name: core.name),
		.target(name: designSystem.name),
		.target(name: resources.name),
		.target(ringForm),
		.target(ringLog),
		.target(undefinedRoute)
	],
	hasTests: false
)
