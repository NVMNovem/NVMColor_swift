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
    
    @available(iOS 14, *)
    convenience init(_ hex: String) {
        self.init(Color(hex))
    }
    
    var hex: String? {
        return Color(self).hex
    }
}
#endif
