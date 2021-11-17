//
//  UIColorExtension.swift
//  
//
//  Created by Damian Van de Kauter on 13/11/2021.
//

#if os(iOS)
import UIKit
import SwiftUI

extension UIColor {
    
    /**
     This initializer  will convert a valid **hex** `String` to a `UIColor`.
     
     - warning: Converting a **hex** to a `UIColor` can cause a slight accuracy loss.
     */
    @available(iOS 14, *)
    public convenience init(hex: String) {
        self.init(Color(hex: hex))
    }
    
    /**
     This variable will convert a `UIColor` to a **hex** `String`.
     
     - warning: Converting a `UIColor` to a **hex** can cause a slight accuracy loss.
     */
    public var hex: String? {
        return Color(self).hex
    }
    
    /**
     Compare a `UIColor` to another `UIColor` by allowing a tolerance.
     
     - parameter color: The color to compare itself with.
     - parameter tolerance: A `CGFloat` of a tolerance from **0** to **1.0**.
     
     - note: The default tolerance is **0.3**.
     */
    @available(iOS 14.0, *)
    public func isEqual(to color: UIColor, tolerance: CGFloat = 0.3) -> Bool {
        var r1 : CGFloat = 0
        var g1 : CGFloat = 0
        var b1 : CGFloat = 0
        var a1 : CGFloat = 0
        var r2 : CGFloat = 0
        var g2 : CGFloat = 0
        var b2 : CGFloat = 0
        var a2 : CGFloat = 0

        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return
            abs(r1 - r2) <= tolerance &&
            abs(g1 - g2) <= tolerance &&
            abs(b1 - b2) <= tolerance &&
            abs(a1 - a2) <= tolerance
    }
}
#endif
