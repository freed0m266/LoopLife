import ProjectDescription

extension TargetScript {
	/// Set build number to Info.plist
    static var setBuildNumber: Self {
        .post(
            path: "BuildPhases/SetBuildNumber.sh",
            name: "Set build number",
            basedOnDependencyAnalysis: false
        )
    }
	
	/// Set app versions to Info.plist
	static var setBundleVersion: TargetScript {
		.post(
			path: "BuildPhases/SetBundleVersion.sh",
			name: "Set app versions",
			basedOnDependencyAnalysis: false
		)
	}

    static var swiftlint: TargetScript {
        .post(
			path: .relativeToRoot("BuildPhases/Swiftlint.sh"),
            name: "Swiftlint",
            basedOnDependencyAnalysis: false
        )
    }
}
