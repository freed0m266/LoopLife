//
//  RingForm.swift
//  ProjectDescriptionHelpers
//
//  Created by Martin Svoboda on 23.01.2026.
//

import Foundation

public let ringForm = Feature(
	name: "RingForm",
	dependencies: [
		.target(name: core.name),
		.target(name: designSystem.name),
		.target(name: resources.name)
	],
	hasTesting: true
)
