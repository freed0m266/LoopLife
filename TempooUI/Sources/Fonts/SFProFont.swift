//
//  SFProFont.swift
//  TempooUI
//
//  Created by Martin Svoboda on 26.06.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import SwiftUI
import TempooResources

public enum SFPro {
	case light      // weight 300
	case regular    // weight 400
	case medium     // weight 500
	case semibold   // weight 600
	case bold       // weight 700
	
	var font: TempooResourcesFontConvertible {
		switch self {
		case .light: TempooResourcesFontFamily.SFPro.light
		case .regular: TempooResourcesFontFamily.SFPro.regular
		case .medium: TempooResourcesFontFamily.SFPro.medium
		case .semibold: TempooResourcesFontFamily.SFPro.semibold
		case .bold: TempooResourcesFontFamily.SFPro.bold
		}
	}
	
	public func font(size: CGFloat) -> UIFont {
		font.font(size: size)
	}
}
