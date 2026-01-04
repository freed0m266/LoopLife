//
//  SFProFont.swift
//  iRingsUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import iRingsResources

public enum SFPro {
	case light      // weight 300
	case regular    // weight 400
	case medium     // weight 500
	case semibold   // weight 600
	case bold       // weight 700
	
	var font: IRingsResourcesFontConvertible {
		switch self {
		case .light: IRingsResourcesFontFamily.SFPro.light
		case .regular: IRingsResourcesFontFamily.SFPro.regular
		case .medium: IRingsResourcesFontFamily.SFPro.medium
		case .semibold: IRingsResourcesFontFamily.SFPro.semibold
		case .bold: IRingsResourcesFontFamily.SFPro.bold
		}
	}
	
	public func font(size: CGFloat) -> UIFont {
		font.font(size: size)
	}
}
