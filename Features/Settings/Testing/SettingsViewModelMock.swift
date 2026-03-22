//
//  SettingsViewModelMock.swift
//  Settings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import TempooCore

final class SettingsViewModelMock: SettingsViewModeling {
	// swiftlint:disable:next force_unwrapping
	var appUrl = URL(string: Environment.appLinkUrlString)!
	var version = "v26.4.12"
	var exportFilename = "LoopLife-Export-2026-03-22"
	var isExporting = false
	var isImporting = false
	var isImportConfirmationShown = false
	var exportDocument: ExportDocument?
	
	func exportData() { }
	func beginImport() { }
	func importData(from data: Data) { }
	func confirmImport() { }
}
