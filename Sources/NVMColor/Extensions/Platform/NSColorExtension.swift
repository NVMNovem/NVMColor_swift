//
//  NSColorExtension.swift
//  
//
//  Created by Damian Van de Kauter on 13/11/2021.
//

#if os(macOS)
import AppKit
import SwiftUI

extension NSColor {
    
    convenience init(_ hex: String) {
        self.init(Color(hex))
    }
    
    var hex: String? {
        return Color(self).hex
    }
}
#endif
