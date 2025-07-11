import ProjectDescription

private let targetName = "LoopLifeCore"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).core"

public let core = Target.target(
	name: targetName,
	destinations: .iOS,
	product: .framework,
	bundleId: bundleID,
	infoPlist: .default,
	sources: "\(targetName)/Sources/**",
	resources: [
		"\(targetName)/Environment/\(Environment.current)/**"
	],
	scripts: [
		.swiftlint
	],
	dependencies: [
		.external(name: "ACKategories"),
		.external(name: "BaseKitX"),
		.external(name: "SwiftyBeaver"),
		.target(name: resources.name)
	],
	coreDataModels: [
		CoreDataModel.coreDataModel("\(targetName)/Local.xcdatamodeld")
	]
)
