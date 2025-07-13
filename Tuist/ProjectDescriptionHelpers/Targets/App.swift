import ProjectDescription

private let targetName = "LoopLife"
private let bundleID = AppSetup.current.bundleID
private let appName = AppSetup.current.appName
private let iconName = AppSetup.current.iconName
private let logoName = AppSetup.current.logoName

public let app = Target.target(
	name: targetName,
	destinations: .init(arrayLiteral: .iPhone),
	product: .app,
	bundleId: bundleID,
	deploymentTargets: .iOS("17.0"),
	infoPlist: .extendingDefault(
		with: [
			"CFBundleDisplayName": .string(appName),
			"ITSAppUsesNonExemptEncryption": false,
			"UILaunchScreen": [
				"UIColorName": "mainWhite",
				"UIImageName": .string(logoName)
			],
			"UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
			"UIUserInterfaceStyle": "Light"
		]
	),
	sources: "\(targetName)/Sources/**",
	resources: [
		"\(targetName)/Resources/**",
		"\(resources.name)/Resources/**/InfoPlist.strings"
	],
	scripts: [
		.setBuildNumber
	],
	dependencies: [
		.target(activity),
		.target(core),
		.target(designSystem),
		.target(example),
		.target(home),
		.target(sheet),
		.target(undefinedRoute)
	],
	settings: .settings(
		base: [
			"ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": true,
			"APPLICATION_EXTENSION_API_ONLY": false,
			"ASSETCATALOG_COMPILER_APPICON_NAME": .string(iconName)
		]
		.merging(AppSetup.current.codeSigning.settingsDictionary)
	)
)

// MARK: - Tests

public let appTests = Target.target(
	name: targetName + "_Tests",
	destinations: .iOS,
	product: .unitTests,
	bundleId: bundleID + ".tests",
	infoPlist: .tests,
	sources: "\(targetName)/Tests/**",
	dependencies: [
		.xctest,
		.target(name: targetName),
		.target(testing)
	]
)
