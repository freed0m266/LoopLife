import Foundation

public struct TeamID: ExpressibleByStringInterpolation, CustomStringConvertible, Sendable {
    public static let freedommartin: Self = "DSKL7YS6PW"

    public let description: String

    public init(stringLiteral value: String) {
        description = value
    }
}
