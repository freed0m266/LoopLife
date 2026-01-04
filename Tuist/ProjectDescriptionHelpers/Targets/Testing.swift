import ProjectDescription

// MARK: - Settings
private let targetName = "iRingsTesting"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).testing"

// MARK: - Target
public let testing = Target.target(
    name: targetName,
    destinations: .iOS,
    product: .framework,
    bundleId: "\(bundleID)",
    infoPlist: .default,
    sources: "\(targetName)/Tests/**",
    dependencies: [
        .xctest,
        .external(name: "SnapshotTesting"),
    ]
)
