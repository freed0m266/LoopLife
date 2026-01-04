import ProjectDescription

public struct Service: Sendable {
	public let implementation: Target
	public let interface: Target
	public let tests: Target
	
	public var allTargets: [Target] { [implementation, interface, tests].compactMap { $0 } }
	
	public init(
		name: String,
		interfaceDependencies: [TargetDependency],
		dependencies: [TargetDependency],
		hasResources: Bool = false
	) {
		let mainBundleID = "com.freedommartin.irings." + name.toBundleID()
		
		interface = .target(
			name: name + "_Interface",
			destinations: .iOS,
			product: .framework,
			bundleId: mainBundleID + ".interface",
			sources: "Services/\(name)/Interface/**",
			dependencies: interfaceDependencies
		)
		
		implementation = .target(
			name: name,
			destinations: .iOS,
			product: .framework,
			bundleId: mainBundleID + ".service",
			sources: "Services/\(name)/Sources/**",
			resources: hasResources ? "Services/\(name)/Resources/**" : nil,
			dependencies: dependencies + [
				.target(interface)
			]
		)
		
		tests = .target(
			name: implementation.name + "_Tests",
			destinations: .iOS,
			product: .unitTests,
			bundleId: mainBundleID + ".unittests",
			sources: "Services/\(name)/Tests/**",
			dependencies: dependencies + [
				.target(implementation)
			]
		)
	}
}

