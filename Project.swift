import ProjectDescription
import ProjectDescriptionHelpers

let features: [Feature] = [
	example,
	home,
	sheet,
	undefinedRoute
]
let services: [Service] = []
let appTargets: [Target] = features.flatMap(\.allTargets) + services.flatMap(\.allTargets)

let project = Project(
    name: "LoopLife",
    organizationName: "Freedom Martin, s.r.o.",
    options: .options(
        developmentRegion: "en"
    ),
    settings: .settings(
        base: [
            "CODE_SIGN_STYLE": .string(AppSetup.current.codeSignStyle),
            "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
            "DEVELOPMENT_TEAM": "\(AppSetup.current.teamID)",
            "IPHONEOS_DEPLOYMENT_TARGET": "17.0",
            "OTHER_LDFLAGS": "-ObjC",
            "MARKETING_VERSION": "0.1.0",
            "SUPPORTS_MACCATALYST": false
        ],
        configurations: AppSetup.current.projectConfigurations
    ),
    targets: [
        app,
        core,
        designSystem,
        designSystemTests,
        resources,
        testing
    ]
    + appTargets
)
