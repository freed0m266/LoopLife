//
//  TextStyles.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public extension View {
	
	// MARK: - Title
	
	/// Title Small
	///
	/// * Font: `SFPro.regular`
	/// * Size: `13`
	/// * Line height: `16`
	func titleSmall() -> some View {
		font(SFPro.regular.font(size: 13), lineHeight: 16, textStyle: .title)
	}
	
	/// Title Medium
	///
	/// * Font: `SFPro.bold`
	/// * Size: `20`
	/// * Line height: `22`
	func titleMedium() -> some View {
		font(SFPro.bold.font(size: 20), lineHeight: 22, textStyle: .title)
	}
	
	/// Title Large
	///
	/// * Font: `SFPro.bold`
	/// * Size: `14`
	/// * Line height: `18`
	func titleLarge() -> some View {
		font(SFPro.bold.font(size: 34), lineHeight: 41, textStyle: .title)
	}
	
	// MARK: - Headline
	
	/// Headline
	///
	/// * Font: `SFPro.medium`
	/// * Size: `14`
	/// * Line height: `14`
	func headline() -> some View {
		font(SFPro.medium.font(size: 14), lineHeight: 14, textStyle: .title)
	}
	
	// MARK: - Text
	
	/// Text Small
	///
	/// * Font: `SFPro.regular`
	/// * Size: `12`
	/// * Line height: `16`
	func textSmall() -> some View {
		font(SFPro.regular.font(size: 12), lineHeight: 16, textStyle: .body)
	}
	
	/// Text Medium
	///
	/// * Font: `SFPro.regular`
	/// * Size: `14`
	/// * Line height: `18`
	func textMedium() -> some View {
		font(SFPro.regular.font(size: 14), lineHeight: 18, textStyle: .body)
	}
	
	/// Text Large
	///
	/// * Font: `SFPro.regular`
	/// * Size: `16`
	/// * Line height: `20`
	func textLarge() -> some View {
		font(SFPro.regular.font(size: 16), lineHeight: 20, textStyle: .body)
	}
	
	// MARK: - Label
	
	/// Label Mini
	///
	/// * Font: `SFPro.medium`
	/// * Size: `10`
	/// * Line height: `12`
	func labelMini() -> some View {
		font(SFPro.medium.font(size: 10), lineHeight: 12, textStyle: .body)
	}
	
	/// Label Small
	///
	/// * Font: `SFPro.medium`
	/// * Size: `12`
	/// * Line height: `16`
	func labelSmall() -> some View {
		font(SFPro.medium.font(size: 12), lineHeight: 16, textStyle: .body)
	}
	
	/// Label Medium
	///
	/// * Font: `SFPro.medium`
	/// * Size: `14`
	/// * Line height: `18`
	func labelMedium() -> some View {
		font(SFPro.medium.font(size: 14), lineHeight: 18, textStyle: .body)
	}
	
	/// Label Large
	///
	/// * Font: `SFPro.semibold`
	/// * Size: `16`
	/// * Line height: `20`
	func labelLarge() -> some View {
		font(SFPro.semibold.font(size: 16), lineHeight: 20, textStyle: .body)
	}
}

#if DEBUG
#Preview {
	ScrollView {
		VStack(spacing: 20) {
			Text("titleSmall").titleSmall()
			Text("titleMedium").titleMedium()
			Text("titleLarge").titleLarge()
			
			Divider()
			
			Text("headline").headline()
			
			Divider()
			
			Text("textSmall").textSmall()
			Text("textMedium").textMedium()
			Text("textLarge").textLarge()
			
			Divider()
			
			Text("labelMini").labelMini()
			Text("labelSmall").labelSmall()
			Text("labelMedium").labelMedium()
			Text("labelLarge").labelLarge()
		}
	}
}
#endif
