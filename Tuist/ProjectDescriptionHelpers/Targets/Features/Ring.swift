//
//  Ring.swift
//  ProjectDescriptionHelpers
//
//  Created by Martin Svoboda on 11.07.2025.
//

import Foundation

public let ring = Feature(
	name: "Ring",
	dependencies: [
		.target(name: core.name),
		.target(name: designSystem.name),
		.target(name: resources.name)
	],
	hasTesting: true
)
