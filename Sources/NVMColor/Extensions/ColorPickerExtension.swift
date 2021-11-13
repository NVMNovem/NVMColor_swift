//
//  ColorPickerExtension.swift
//  
//
//  Created by Damian Van de Kauter on 13/11/2021.
//

import Foundation

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
    @inlinable public func colorChange(of color: Color, perform action: @escaping (_ hex: String) -> Void) -> some View {
        return self.onChange(of: color) { newColor in
            if let hexColor = newColor.hex, !"\(newColor)".isHex() {
                action(hexColor)
            }
        }
    }
}
