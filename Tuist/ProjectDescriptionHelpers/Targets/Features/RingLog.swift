//
//  RingLog.swift
//  ProjectDescriptionHelpers
//
//  Created by Martin Svoboda on 28.12.2025.
//

import Foundation

public let ringLog = Feature(
	name: "RingLog",
	dependencies: [
		.target(name: core.name),
		.target(name: designSystem.name),
		.target(name: resources.name)
	],
	hasTesting: true
)
