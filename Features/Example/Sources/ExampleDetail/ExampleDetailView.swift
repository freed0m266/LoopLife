//
//  ExampleDetailView.swift
//  Example
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsUI

public struct ExampleDetailView<ViewModel: ExampleDetailViewModeling>: View {
	@StateObject private var viewModel: ViewModel
	
	public init(viewModel: ViewModel) {
		_viewModel = .init(wrappedValue: viewModel)
	}

    public var body: some View {
		ScreenView(title: "ExampleDetail (\(viewModel.example.id))") {
			VStack(spacing: 16) {
				LLHeadline(viewModel.example.text)
				
				Text(
				  """
				  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget feugiat augue, vitae semper ipsum.
				  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget feugiat augue, vitae semper ipsum.
				  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget feugiat augue, vitae semper ipsum.
				  """
				)
				.textLarge()
				.foregroundColor(.foregroundPrimary)
				.maxWidthLeading()
				.padding(16)
			}
			.padding(.vertical, 64)
		}
		.overlay(alignment: .bottom) {
			PrimaryButton(foreground: .basicWhite, background: .basicBlue) {
				
			} label: {
				Text("Primary Button")
					.labelLarge()
					.frame(maxWidth: .infinity)
			}
			.padding(16)
		}
    }
}

#if DEBUG
#Preview {
	ExampleDetailView(viewModel: ExampleDetailViewModelMock())
		.inPreview()
}
#endif
