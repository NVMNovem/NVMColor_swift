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
    
    /**
     This initializer  will convert a valid **hex** `String` to a `NSColor`.
     
     - warning: Converting a **hex** to a `NSColor` can cause a slight accuracy loss.
     */
    public convenience init(hex: String) {
        self.init(Color(hex: hex))
    }
    
    /**
     This variable will convert a `NSColor` to a **hex** `String`.
     
     - warning: Converting a `NSColor` to a **hex** can cause a slight accuracy loss.
     */
    public var hex: String? {
        return Color(self).hex
    }
}
#endif
