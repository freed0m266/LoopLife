import ProjectDescription

extension TargetScript {
    static var setBuildNumber: Self {
        .post(
            path: "BuildPhases/SetBuildNumber.sh",
            name: "Set build number",
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
