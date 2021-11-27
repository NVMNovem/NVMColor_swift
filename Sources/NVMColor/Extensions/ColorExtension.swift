//
//  ColorExtension.swift
//  
//
//  Created by Damian Van de Kauter on 13/11/2021.
//

import SwiftUI

extension Color {
    
    /**
     This initializer  will convert a valid **hex** `String` to a `Color`.
     
     - warning: Converting a **hex** to a `Color` can cause a slight accuracy loss.
     */
    public init(hex: String) {
        let hex = hex.cleanedHex
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
    
    /**
     This variable will convert a `Color` to a **hex** `String`.
     
     - warning: Converting a `Color` to a **hex** can cause a slight accuracy loss.
     */
    public var hex: String? {
        let colorString = "\(self)"
        if let colorHex = colorString.isHex() {
            return colorHex.cleanedHex
        } else {
            var colorArray: [String] = colorString.components(separatedBy: " ")
            if colorArray.count < 3 { colorArray = colorString.components(separatedBy: ", ") }
            if colorArray.count < 3 { colorArray = colorString.components(separatedBy: ",") }
            if colorArray.count < 3 { colorArray = colorString.components(separatedBy: " - ") }
            if colorArray.count < 3 { colorArray = colorString.components(separatedBy: "-") }
            
            colorArray = colorArray.filter { colorElement in
                return (!colorElement.isEmpty) && (String(colorElement).replacingOccurrences(of: ".", with: "").rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil)
            }
            
            if (colorArray.count == 3) || (colorArray.count == 4) { //count == 4 if alpha is set
                var r: CGFloat = CGFloat((Float(colorArray[0]) ?? 1))
                var g: CGFloat = CGFloat((Float(colorArray[1]) ?? 1))
                var b: CGFloat = CGFloat((Float(colorArray[2]) ?? 1))
                
                if (r < 0.0) {r = 0.0}
                if (g < 0.0) {g = 0.0}
                if (b < 0.0) {b = 0.0}
                
                if (r > 1.0) {r = 1.0}
                if (g > 1.0) {g = 1.0}
                if (b > 1.0) {b = 1.0}
                
                let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
                return String(format: "#%06X", rgb).cleanedHex
            } else {
                return nil
            }
        }
    }
    
    /**
     Compare a `Color` to another `Color` by allowing a tolerance.
     
     - parameter color: The color to compare itself with.
     - parameter tolerance: A `CGFloat` of a tolerance from **0** to **1.0**.
     
     - note: The default tolerance is **0.3**.
     */
    @available(iOS 14.0, *)
    public func isEqual(to color: Color, tolerance: CGFloat = 0.3) -> Bool {
        #if os(iOS)
        var r1 : CGFloat = 0
        var g1 : CGFloat = 0
        var b1 : CGFloat = 0
        var a1 : CGFloat = 0
        var r2 : CGFloat = 0
        var g2 : CGFloat = 0
        var b2 : CGFloat = 0
        var a2 : CGFloat = 0

        UIColor(self).getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        UIColor(color).getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return
            abs(r1 - r2) <= tolerance &&
            abs(g1 - g2) <= tolerance &&
            abs(b1 - b2) <= tolerance &&
            abs(a1 - a2) <= tolerance
        #elseif os(macOS)
        if let newSelfColor = NSColor(self).usingColorSpace(.deviceRGB) {
            if let newColor = NSColor(color).usingColorSpace(.deviceRGB) {
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
        #endif
    }
    
    /**
     This variable will convert a `Color` to a themed `Color`.
     If the **device theme** is dark, and the input is dark, it will return `Color.primary`.
     If the **device theme** is light, and the input is light, it will return `Color.primary`.
     
     - note: Comparison is calculated with a **0.2** tolerance.
     */
    @available(iOS 14.0, *)
    public var themedMonoColor: Color {
        if ((self.isEqual(to: .black, tolerance: 0.2)) || (self.isEqual(to: .white, tolerance: 0.2))) {
            return Color.primary
        } else {
            return self
        }
    }
}
