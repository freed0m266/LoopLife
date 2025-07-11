import struct ProjectDescription.Configuration
import struct ProjectDescription.SettingsDictionary

public struct AppSetup {
	public static var current: Self {
		.init(environment: .current, configuration: .current)
	}
	
	public let environment: Environment
	public let configuration: Configuration
	public let moduleBundleIDPrefix = "com.freedommartin.looplife"
	
	public var bundleID: String {
		switch configuration {
		case .debug:
			moduleBundleIDPrefix + ".debug"
		case .beta:
			moduleBundleIDPrefix + ".beta"
		case .release:
			moduleBundleIDPrefix
		}
	}
	
	public var teamID: TeamID {
		.freedommartin
	}
	
	public var codeSignStyle: String {
		switch configuration {
		case .debug: 
			"Automatic"
		case .beta, .release:
			"Manual"
		}
	}
	
	public var codeSigning: CodeSigning {
		switch configuration {
		case .debug:
			.init(
				developmentTeam: AppSetup.current.teamID,
				identity: "Apple Development",
				provisioningSpecifier: "" // Xcode will select `Automatic`
			)
		case .beta, .release:
			.init(
				developmentTeam: AppSetup.current.teamID,
				identity: "Apple Distribution",
				// TODO: Fill provisioningSpecifier
				provisioningSpecifier: "" + bundleID
			)
		}
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
		["LoopLife", environment.appNameValue].joined(separator: " ")
	}
	
	public var iconName: String {
		"Icon-LoopLife"
	}
	
	public var logoName: String {
		"Logo-LoopLife"
	}
}

extension AppSetup: CustomStringConvertible {
	public var description: String { "\(configuration)/\(environment)" }
}
