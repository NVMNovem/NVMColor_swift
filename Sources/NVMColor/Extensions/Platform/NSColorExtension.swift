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
    public convenience init?(hex: String?) {
        guard let color = Color(hex: hex) else { return nil }
        self.init(color)
    }
    
    /**
     This variable will convert a `NSColor` to a **hex** `String`.
     
     - warning: Converting a `NSColor` to a **hex** can cause a slight accuracy loss.
     */
    public var hex: String? {
        return Color(self).hex
    }
    
    /**
     Compare a `NSColor` to another `NSColor` by allowing a tolerance.
     
     - parameter color: The color to compare itself with.
     - parameter tolerance: A `CGFloat` of a tolerance from **0** to **1.0**.
     
     - note: The default tolerance is **0.3**.
     */
    public func isEqual(to color: NSColor, tolerance: CGFloat = 0.3) -> Bool {
        if let newSelfColor = self.usingColorSpace(.deviceRGB) {
            if let newColor = color.usingColorSpace(.deviceRGB) {
                var r1 : CGFloat = 0
                var g1 : CGFloat = 0
                var b1 : CGFloat = 0
                var a1 : CGFloat = 0
                var r2 : CGFloat = 0
                var g2 : CGFloat = 0
                var b2 : CGFloat = 0
                var a2 : CGFloat = 0

                
                newSelfColor.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
                newColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

                return
                    abs(r1 - r2) <= tolerance &&
                    abs(g1 - g2) <= tolerance &&
                    abs(b1 - b2) <= tolerance &&
                    abs(a1 - a2) <= tolerance
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
#endif
