//
//  Settings.swift
//  ProjectDescriptionHelpers
//
//  Created by Martin Svoboda on 22.01.2026.
//

import Foundation

public let settings = Feature(
	name: "Settings",
	dependencies: [
		.target(name: core.name),
		.target(name: designSystem.name),
		.target(name: resources.name)
	],
	hasTesting: true
)
