//
//  LinearGradient+Extensions.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI

public extension LinearGradient {
	static var primaryRing: LinearGradient {
		.init(
			colors: [
				Color(hexString: "00C2FF"),
				Color(hexString: "6A00FF")
			],
			startPoint: .topLeading,
			endPoint: .bottomTrailing
		)
	}
	
	static var successRing: LinearGradient {
		.init(
			colors: [
				Color(hexString: "00FF94"),
				Color(hexString: "00C2FF")
			],
			startPoint: .topLeading,
			endPoint: .bottomTrailing
		)
	}
	
	static var dangerZoneRing: LinearGradient {
		.init(
			colors: [
				Color(hexString: "FF5C5C"),
				Color(hexString: "FFA26B")
			],
			startPoint: .topLeading,
			endPoint: .bottomTrailing
		)
	}
	
	static var backgroundSoft: LinearGradient {
		.init(
			colors: [
				Color(hexString: "1C1C1D"),
				Color(hexString: "242424")
			],
			startPoint: .leading,
			endPoint: .topTrailing
		)
	}
	
	static var fitness: LinearGradient {
		.init(
			colors: [
				Color(hexString: "00C2FF"),
				Color(hexString: "6A00FF")
			],
			startPoint: .topLeading,
			endPoint: .bottomTrailing
		)
	}
	
	static var reading: LinearGradient {
		.init(
			colors: [
				Color(hexString: "FFA26B"),
				Color(hexString: "FF5C5C")
			],
			startPoint: .topLeading,
			endPoint: .bottomTrailing
		)
	}
	
	static var finance: LinearGradient {
		.init(
			colors: [
				Color(hexString: "00FF94"),
				Color(hexString: "00C2FF")
			],
			startPoint: .topLeading,
			endPoint: .bottomTrailing
		)
	}
	
	static var habit: LinearGradient {
		.init(
			colors: [
				Color(hexString: "FFD500"),
				Color(hexString: "FF6A00")
			],
			startPoint: .topLeading,
			endPoint: .bottomTrailing
		)
	}
	
	static var custom: LinearGradient {
		.init(
			colors: [
				Color(hexString: "A3A3A3"),
				Color(hexString: "595959")
			],
			startPoint: .topLeading,
			endPoint: .bottomTrailing
		)
	}
}

#if DEBUG
struct LinearGradients_Previews: PreviewProvider {

	static var previews: some View {
		ScrollView {
			VStack(spacing: 16) {
				preview(of: .primaryRing, title: "primaryRing")

				preview(of: .successRing, title: "successRing")

				preview(of: .dangerZoneRing, title: "dangerZoneRing")

				preview(of: .fitness, title: "fitness")
				
				preview(of: .reading, title: "reading")
				
				preview(of: .finance, title: "finance")
				
				preview(of: .habit, title: "habit")
				
				preview(of: .custom, title: "custom")

				preview(of: .backgroundSoft, title: "backgroundSoft", textColor: .foregroundPrimary)
			}
			.padding(16)
		}
		.backgroundColor(.backgroundPrimary)
	}

	static func preview(
		of linearGradient: LinearGradient,
		title: String,
		textColor: ColorItem = .foregroundOnPrimary
	) -> some View {
		RoundedRectangle(cornerRadius: 5)
			.fill(linearGradient)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.aspectRatio(2.25, contentMode: .fit)
			.overlay(alignment: .topLeading) {
				Text(title)
					.font(.system(size: 11, weight: .bold))
					.foregroundColor(textColor)
					.padding(8)
			}
			.padding(.horizontal, 8)
	}
}
#endif
