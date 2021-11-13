//
//  ColorExtension.swift
//  
//
//  Created by Damian Van de Kauter on 13/11/2021.
//

import Foundation

public extension Color {
    var hex: String? {
        let colorString = "\(self)"
        if let colorHex = colorString.isHex() {
            return colorHex
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
                
                let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
                return String(format: "#%06X", rgb).replacingOccurrences(of: "#", with: "")
            } else {
                return nil
            }
        }
    }
}
