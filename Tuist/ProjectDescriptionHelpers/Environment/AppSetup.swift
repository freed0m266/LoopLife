import struct ProjectDescription.Configuration
import struct ProjectDescription.SettingsDictionary

public struct AppSetup {
	public static var current: Self {
		.init(environment: .current)
	}
	
	public let environment: Environment
	public let moduleBundleIDPrefix = "com.freedommartin.irings"
	
	public var bundleID: String {
		switch environment {
		case .development:
			moduleBundleIDPrefix + ".debug"
		case .testing:
			moduleBundleIDPrefix + ".beta"
		case .production:
			moduleBundleIDPrefix
		}
	}
	
	public var teamID: TeamID {
		.freedommartin
	}
	
	public var codeSignStyle: String {
		"Automatic"
	}
	
	public var codeSigning: CodeSigning {
		CodeSigning(
			developmentTeam: AppSetup.current.teamID,
			identity: "Apple Development",
			provisioningSpecifier: "" // Xcode will select `Automatic`
		)
	}
	
	public var projectConfigurations: [ProjectDescription.Configuration] {
		[
			.debug(name: "Debug", settings: settings),
			.release(name: "Release", settings: settings)
		]
	}
	
	private var settings: SettingsDictionary {
		switch environment {
		case .development:
			SettingsDictionary()
				.swiftActiveCompilationConditions(["DEV"])
		case .testing:
			SettingsDictionary()
				.swiftActiveCompilationConditions(["TEST"])
		case .production:
			SettingsDictionary()
				.swiftActiveCompilationConditions(["PROD"])
		}
	}
}

extension AppSetup {
	public var appName: String {
		["iRings", environment.appNameValue].joined(separator: " ")
	}
	
	public var iconName: String {
		"Icon-iRings"
	}
	
	public var logoName: String {
		"Logo-iRings"
	}
}

extension AppSetup: CustomStringConvertible {
	public var description: String { "\(environment)" }
}
