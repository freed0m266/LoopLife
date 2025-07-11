//
//  Sheet.swift
//  ProjectDescriptionHelpers
//
//  Created by Martin Svoboda on 03.07.2025.
//

import Foundation

public let example = Feature(
	name: "Example",
	dependencies: [
		.target(name: core.name),
		.target(name: designSystem.name),
		.target(name: resources.name)
	],
	hasTests: true,
	hasTesting: true
)
