import ProjectDescription

public struct CodeSigning {
    public let developmentTeam: TeamID
    public let identity: String
    public let provisioningSpecifier: String

    public var settingsDictionary: SettingsDictionary {
        [
            "DEVELOPMENT_TEAM": .string(developmentTeam.description),
            "CODE_SIGN_IDENTITY": .string(identity),
            "PROVISIONING_PROFILE_SPECIFIER": .string(provisioningSpecifier),
        ]
    }
}
