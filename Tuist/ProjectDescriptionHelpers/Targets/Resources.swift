import ProjectDescription

private let targetName = "LoopLifeResources"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).resources"

public let resources = Target.target(
    name: targetName,
    destinations: .iOS,
    product: .framework,
    bundleId: bundleID,
    infoPlist: .default,
    sources: "\(targetName)/Sources/**",
    resources: "\(targetName)/Resources/**"
)
