//
//  SFProFont.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import LoopLifeResources

public enum SFPro {
	case light      // weight 300
	case regular    // weight 400
	case medium     // weight 500
	case semibold   // weight 600
	case bold       // weight 700
	
	var font: LoopLifeResourcesFontConvertible {
		switch self {
		case .light: LoopLifeResourcesFontFamily.SFPro.light
		case .regular: LoopLifeResourcesFontFamily.SFPro.regular
		case .medium: LoopLifeResourcesFontFamily.SFPro.medium
		case .semibold: LoopLifeResourcesFontFamily.SFPro.semibold
		case .bold: LoopLifeResourcesFontFamily.SFPro.bold
		}
	}
	
	public func font(size: CGFloat) -> UIFont {
		font.font(size: size)
	}
}
