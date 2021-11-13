//
//  ColorPickerExtension.swift
//  
//
//  Created by Damian Van de Kauter on 13/11/2021.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension ColorPicker {
    
    /**
     This ColorPicker function allows you to easily catch the HEX String.
     If a ColorPicker set's it's first color in the .onAppear, it normally triggers an .onChange.
     This function makes sure it doesn't do that.
     It will only be triggered when the color changes.
     */
    @inlinable public func onHexChange(of color: Color, oldColor: Color? = nil, perform action: @escaping (_ hex: String) -> Void) -> some View {
        return self.onColorChange(of: color) { color in
            if let hexColor = color.hex {
                action(hexColor.cleanedHex)
            }
        }
    }
    
    /**
     This ColorPicker function allows you to easily catch the HEX String.
     If a ColorPicker set's it's first color in the .onAppear, it normally triggers an .onChange.
     This function makes sure it doesn't do that.
     It will only be triggered when the color changes.
     */
    @inlinable public func onColorChange(of color: Color, oldColor: Color? = nil, perform action: @escaping (_ color: Color) -> Void) -> some View {
        return self.onChange(of: color) { newColor in
            if let oldColor = oldColor, newColor != oldColor {
                action(newColor)
            } else {
                if !"\(newColor)".isHex() {
                    action(newColor)
                }
            }
        }
    }
}
