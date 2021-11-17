import SwiftUI

public struct NVMColor {
    
    /**
     Get a **hex** `String` from a valid `Color`.
     
     - parameter color: The valid `Color`.
     
     - warning: Converting a `Color` to a **hex** can cause a slight accuracy loss.
     */
    public static func getHex(from color: Color) -> String? {
        return color.hex
    }
    
    /**
     Get a `Color` from a valid **hex** `String`.
     
     - parameter color: The valid **hex** `String`.
     
     - warning: Converting a **hex** to a `Color` can cause a slight accuracy loss.
     */
    public static func getColor(from hex: String) -> Color {
        return Color(hex: hex)
    }
    
    /**
     Compare a `Color` to another `Color` by allowing a tolerance.
     
     - parameter color1: The first `Color` to compare.
     - parameter color2: The second `Color` to compare.
     - parameter tolerance: A `CGFloat` of a tolerance from **0** to **1.0**.
     
     - note: The default tolerance is **0.3**.
     */
    @available(iOS 14.0, *)
    public static func colorsAreEqual(_ color1: Color, to color2: Color, tolerance: CGFloat = 0.3) -> Bool {
        return color1.isEqual(to: color2, tolerance: tolerance)
    }
}

