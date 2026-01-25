//
//  LLTextEditor.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 17.01.2026.
//  Copyright © 2026 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public struct LLTextEditor: View {
	@State private var inputString = ""
	@Binding private var text: String?
	@FocusState private var isActive: Bool
	
	private let placeholder: String
	
	public init(
		_ placeholder: String = "",
		text: Binding<String?>
	) {
		self.placeholder = placeholder
		self._text = text
	}
	
	public var body: some View {
		TextEditor(text:
			Binding(
				get: { inputString },
				set: { inputString = $0 }
			)
		)
		.focused($isActive)
		.titleMedium()
		.foregroundColor(.skyBlue)
		.padding(.vertical, 4)
		.padding(.horizontal, 12)
		.backgroundColor(.backgroundSecondary)
		.scrollContentBackground(.hidden)
		.cornerRadius(10)
		.overlay(alignment: .topLeading) {
			if text.isEmpty {
				Text(placeholder)
					.titleMedium()
					.foregroundColor(.foregroundSecondary)
					.padding(.vertical, 12)
					.padding(.horizontal, 16)
					.onTapGesture {
						isActive = true
					}
			}
		}
		.onChange(of: inputString) { _, newValue in
			// Clear value if input is empty
			text = newValue.isEmpty ? nil : newValue
		}
		.onChange(of: text) { _, newValue in
			if let text {
				inputString = text
			}
		}
		.onTapGesture {
			// Thanks to this LLTextEditor is excluded from hiding keyboard taps
			isActive = true
		}
	}
}

#if DEBUG
#Preview {
	VStack(spacing: 40) {
		LLTextEditor(
			"Placeholder",
			text: .constant("")
		)
		
		LLTextEditor(
			"Placeholder",
			text: .constant(
 """
 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget feugiat augue, vitae semper ipsum.
 """
			)
		)
		
		LLTextEditor(
			"Zde prosím popište s čím nejste spokojeni… spokojeni spokojeni spokojeni",
			text: .constant(
 """
 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget feugiat augue, vitae semper ipsum.
 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget feugiat augue, vitae semper ipsum.
 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget feugiat augue, vitae semper ipsum.
 """
			)
		)
	}
	.padding(16)
	.backgroundColor(.backgroundSecondary)
}
#endif
