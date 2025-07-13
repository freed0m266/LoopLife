import ProjectDescription

private let targetName = "LoopLifeUI"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).ui"

public let designSystem = Target.target(
    name: targetName,
    destinations: .iOS,
    product: .framework,
    bundleId: bundleID,
    infoPlist: .default,
    sources: "\(targetName)/Sources/**",
    dependencies: [
        .target(name: resources.name),
        .target(name: core.name),
		.external(name: "MKRingProgressView")
    ]
)

public let designSystemTests = Target.target(
    name: targetName + "_Tests",
    destinations: .iOS,
    product: .unitTests,
    bundleId: bundleID + ".unittests",
    sources: "\(targetName)/Tests/**",
    dependencies: [
        .target(designSystem),
        .target(testing)
    ]
)
