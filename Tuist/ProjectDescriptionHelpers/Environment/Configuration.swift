import enum ProjectDescription.Environment

public enum Configuration: String {
	public static var current: Self {
		.init(
			rawValue: ProjectDescription.Environment.configuration
				.getString(default: Self.debug.rawValue)
		) ?? .debug
	}
	
	case debug = "Debug"
	case beta = "Beta"
	case release = "Release"
	
	var isDebug: Bool {
		self == .debug
	}
}

extension Configuration: CustomStringConvertible {
	public var description: String { rawValue }
}
