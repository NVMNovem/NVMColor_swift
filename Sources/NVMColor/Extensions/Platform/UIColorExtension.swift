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
}
#endif
