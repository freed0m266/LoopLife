//
//  ExportDocument.swift
//  Settings
//
//  Created by Martin Svoboda on 22.03.2026.
//  Copyright © 2026 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

public struct ExportDocument: FileDocument {
	public static var readableContentTypes: [UTType] { [.json] }
	
	public let data: Data
	
	public init(data: Data) {
		self.data = data
	}
	
	public init(configuration: ReadConfiguration) throws {
		guard let data = configuration.file.regularFileContents else {
			throw CocoaError(.fileReadCorruptFile)
		}
		self.data = data
	}
	
	public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		FileWrapper(regularFileWithContents: data)
	}
}
