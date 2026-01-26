import enum ProjectDescription.Environment

public enum Environment: String {
	public static var current: Self {
		.init(
			rawValue: ProjectDescription.Environment.environment
				.getString(default: Self.development.rawValue)
		) ?? .development
	}
	
	case development = "Development"
	case testing = "Testing"
	case production = "Production"
	
	var isDebug: Bool {
		self == .development || self == .testing
	}
	
	public var appNameValue: String {
		switch self {
		case .development: "DEV"
		case .testing: "TEST"
		case .production: ""
		}
	}
}

extension Environment: CustomStringConvertible {
	public var description: String { rawValue }
}
