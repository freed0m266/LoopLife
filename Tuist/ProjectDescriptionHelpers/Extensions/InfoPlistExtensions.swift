import ProjectDescription

extension InfoPlist {
	/// Generates default content for the tests target the InfoPlist belongs to
	static var tests: InfoPlist {
		.extendingDefault(
			with: [
				"NSPrincipalClass": .string(core.name + ".PrincipalClass")
			]
		)
	}
}
