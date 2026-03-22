//
//  SettingsViewModel.swift
//  Settings
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import iRingsCore
import iRingsResources

public protocol SettingsViewModeling: ObservableObject {
	var version: String { get }
	var appUrl: URL { get }
	var isExporting: Bool { get set }
	var isImporting: Bool { get set }
	var isImportConfirmationShown: Bool { get set }
	var exportDocument: ExportDocument? { get }
	var exportFilename: String { get }
	
	func exportData()
	func beginImport()
	func importData(from data: Data)
	func confirmImport()
}

public func settingsVM() -> some SettingsViewModeling {
	SettingsViewModel(dependencies: dependencies.settings)
}

final class SettingsViewModel: BaseViewModel, SettingsViewModeling {
	
	typealias Texts = L10n.Settings
	
	var appUrl: URL {
		// swiftlint:disable:next force_unwrapping
		URL(string: Environment.appLinkUrlString)!
	}
	
	var version: String {
		guard let version = Bundle.main.version else { return "" }
		return "v\(version)"
	}
	
	var exportFilename: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return "iRings-Export-\(formatter.string(from: .now))"
	}
	
	@Published var isExporting = false
	@Published var isImporting = false
	@Published var isImportConfirmationShown = false
	@Published var exportDocument: ExportDocument?
	
    private let dependencies: SettingsDependencies
	private var pendingImportData: Data?
	
    // MARK: - Init

	init(dependencies: SettingsDependencies) {
        self.dependencies = dependencies
		super.init()
		setupBindings()
    }
	
	// MARK: - Public API
	
	func beginImport() {
		isImporting = true
	}
	
	func exportData() {
		do {
			let data = try dependencies.dataMigrationManager.exportData()
			exportDocument = ExportDocument(data: data)
			isExporting = true
		} catch {
			Logger.error(error)
			presentToast(item: .failure(Texts.exportFailed))
		}
	}
	
	func importData(from data: Data) {
		pendingImportData = data
		isImportConfirmationShown = true
	}
	
	func confirmImport() {
		guard let data = pendingImportData else { return }
		pendingImportData = nil
		
		do {
			let result = try dependencies.dataMigrationManager.importData(from: data)
			presentToast(item: .success(Texts.importSuccess(result.ringsCount)))
		} catch {
			Logger.error(error)
			presentToast(item: .failure(Texts.importFailed))
		}
	}
	
	// MARK: - Private API
	
	private func setupBindings() {
		
	}
}
