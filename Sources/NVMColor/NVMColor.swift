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
     
     - note: If no `Color` could be created, the default **Color.primary** is returned.
     - warning: Converting a **hex** to a `Color` can cause a slight accuracy loss.
     */
    public static func getColor(from hex: String) -> Color {
        return Color(hex: hex) ?? .primary
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
    
    /**
     Get the 4 main colors of image data if any found.
     
     - parameter data: The `Data` from an image.
     - parameter quality: The `NVMImageColorsQuality` that sets the quality.
     
     - important: Make sure to use valid image data. Invalid image data wil return **nil**.
     */
    public static func getImageColors(from data: Data, quality: NVMImageColorsQuality = .high) -> NVMImageColors? {
        #if os(macOS)
        guard let platformImage = NSImage(data: data) else { return nil }
        #else
        guard let platformImage = UIImage(data: data) else { return nil }
        #endif
        var scaleDownSize: CGSize = platformImage.size
        if quality != .highest {
            if platformImage.size.width < platformImage.size.height {
                let ratio = platformImage.size.height/platformImage.size.width
                scaleDownSize = CGSize(width: quality.rawValue/ratio, height: quality.rawValue)
            } else {
                let ratio = platformImage.size.width/platformImage.size.height
                scaleDownSize = CGSize(width: quality.rawValue, height: quality.rawValue/ratio)
            }
        }
        
        guard let resizedImage = platformImage.resizeForUIImageColors(newSize: scaleDownSize) else { return nil }

        #if os(macOS)
            guard let cgImage = resizedImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else { return nil }
        #else
            guard let cgImage = resizedImage.cgImage else { return nil }
        #endif
        
        let width: Int = cgImage.width
        let height: Int = cgImage.height
        
        let threshold = Int(CGFloat(height)*0.01)
        var proposed: [Double] = [-1,-1,-1,-1]
        
        guard let data = CFDataGetBytePtr(cgImage.dataProvider!.data) else {
            fatalError("UIImageColors.getColors failed: could not get cgImage data.")
        }
        
        let imageColors = NSCountedSet(capacity: width*height)
        for x in 0..<width {
            for y in 0..<height {
                let pixel: Int = ((width * y) + x) * 4
                if 127 <= data[pixel+3] {
                    imageColors.add((Double(data[pixel+2])*1000000)+(Double(data[pixel+1])*1000)+(Double(data[pixel])))
                }
            }
        }

        let sortedColorComparator: Comparator = { (main, other) -> ComparisonResult in
            let m = main as! NVMImageColorsCounter, o = other as! NVMImageColorsCounter
            if m.count < o.count {
                return .orderedDescending
            } else if m.count == o.count {
                return .orderedSame
            } else {
                return .orderedAscending
            }
        }
        
        var enumerator = imageColors.objectEnumerator()
        var sortedColors = NSMutableArray(capacity: imageColors.count)
        while let K = enumerator.nextObject() as? Double {
            let C = imageColors.count(for: K)
            if threshold < C {
                sortedColors.add(NVMImageColorsCounter(color: K, count: C))
            }
        }
        sortedColors.sort(comparator: sortedColorComparator)

        var proposedEdgeColor: NVMImageColorsCounter
        if 0 < sortedColors.count {
            proposedEdgeColor = sortedColors.object(at: 0) as! NVMImageColorsCounter
        } else {
            proposedEdgeColor = NVMImageColorsCounter(color: 0, count: 1)
        }
        
        if proposedEdgeColor.color.isBlackOrWhite && 0 < sortedColors.count {
            for i in 1..<sortedColors.count {
                let nextProposedEdgeColor = sortedColors.object(at: i) as! NVMImageColorsCounter
                if Double(nextProposedEdgeColor.count)/Double(proposedEdgeColor.count) > 0.3 {
                    if !nextProposedEdgeColor.color.isBlackOrWhite {
                        proposedEdgeColor = nextProposedEdgeColor
                        break
                    }
                } else {
                    break
                }
            }
        }
        proposed[0] = proposedEdgeColor.color

        enumerator = imageColors.objectEnumerator()
        sortedColors.removeAllObjects()
        sortedColors = NSMutableArray(capacity: imageColors.count)
        let findDarkTextColor = !proposed[0].isDarkColor
        
        while var K = enumerator.nextObject() as? Double {
            K = K.with(minSaturation: 0.15)
            if K.isDarkColor == findDarkTextColor {
                let C = imageColors.count(for: K)
                sortedColors.add(NVMImageColorsCounter(color: K, count: C))
            }
        }
        sortedColors.sort(comparator: sortedColorComparator)
        
        for color in sortedColors {
            let color = (color as! NVMImageColorsCounter).color
            
            if proposed[1] == -1 {
                if color.isContrasting(proposed[0]) {
                    proposed[1] = color
                }
            } else if proposed[2] == -1 {
                if !color.isContrasting(proposed[0]) || !proposed[1].isDistinct(color) {
                    continue
                }
                proposed[2] = color
            } else if proposed[3] == -1 {
                if !color.isContrasting(proposed[0]) || !proposed[2].isDistinct(color) || !proposed[1].isDistinct(color) {
                    continue
                }
                proposed[3] = color
                break
            }
        }
        
        let isDarkBackground = proposed[0].isDarkColor
        for i in 1...3 {
            if proposed[i] == -1 {
                proposed[i] = isDarkBackground ? 255255255:0
            }
        }
        
        return NVMImageColors(
            background: proposed[0].color,
            primary: proposed[1].color,
            secondary: proposed[2].color,
            detail: proposed[3].color
        )
    }
}

public struct NVMImageColors {
    public var background: Color
    public var primary: Color
    public var secondary: Color
    public var detail: Color
  
    public init(background: Color, primary: Color, secondary: Color, detail: Color) {
      self.background = background
      self.primary = primary
      self.secondary = secondary
      self.detail = detail
    }
}

public extension NVMImageColors {
    
    /**
     This variable will return the most colored `Color`.
     
     - note: Comparison is calculated with a **0.3** tolerance.
     */
    @available(iOS 14.0, *)
    var prominentColor: Color {
        let tolerance: CGFloat = 0.3
        var mainColor: Color = self.background
        if ((mainColor.isEqual(to: .white, tolerance: tolerance)) || (mainColor.isEqual(to: .black, tolerance: tolerance))) {
            mainColor = self.detail
            
            if ((mainColor.isEqual(to: .white, tolerance: tolerance)) || (mainColor.isEqual(to: .black, tolerance: tolerance))) {
                mainColor = self.primary
                
                if ((mainColor.isEqual(to: .white, tolerance: tolerance)) || (mainColor.isEqual(to: .black, tolerance: tolerance))) {
                    mainColor = self.secondary
                    
                    if ((mainColor.isEqual(to: .white, tolerance: tolerance)) || (mainColor.isEqual(to: .black, tolerance: tolerance))) {
                        mainColor = self.background
                    }
                }
            }
        }
        return mainColor
    }
}

public enum NVMImageColorsQuality: CGFloat {
    
    /**
     The lowest scale.
     */
    case lowest = 50
    
    /**
     The low scale.
     */
    case low = 100
    
    /**
     The high scale.
     */
    case high = 250
    
    /**
     The highest scale.
     */
    case highest = 0
}

#if os(macOS)
fileprivate extension NSImage {
    func resizeForUIImageColors(newSize: CGSize) -> NSImage? {
        let frame = CGRect(origin: .zero, size: newSize)
        guard let representation = bestRepresentation(for: frame, context: nil, hints: nil) else {
            return nil
        }
        let result = NSImage(size: newSize, flipped: false, drawingHandler: { (_) -> Bool in
            return representation.draw(in: frame)
        })
        
        return result
    }
}
#else
fileprivate extension UIImage {
    func resizeForUIImageColors(newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError("UIImageColors.resizeForUIImageColors failed: UIGraphicsGetImageFromCurrentImageContext returned nil.")
        }
        
        return result
    }
}
#endif

fileprivate extension Double {
    
    private var r: Double {
        return fmod(floor(self/1000000),1000000)
    }
    
    private var g: Double {
        return fmod(floor(self/1000),1000)
    }
    
    private var b: Double {
        return fmod(self,1000)
    }
    
    var isDarkColor: Bool {
        return (r*0.2126) + (g*0.7152) + (b*0.0722) < 127.5
    }
    
    var isBlackOrWhite: Bool {
        return (r > 232 && g > 232 && b > 232) || (r < 23 && g < 23 && b < 23)
    }
    
    func isDistinct(_ other: Double) -> Bool {
        let _r = self.r
        let _g = self.g
        let _b = self.b
        let o_r = other.r
        let o_g = other.g
        let o_b = other.b

        return (fabs(_r-o_r) > 63.75 || fabs(_g-o_g) > 63.75 || fabs(_b-o_b) > 63.75)
            && !(fabs(_r-_g) < 7.65 && fabs(_r-_b) < 7.65 && fabs(o_r-o_g) < 7.65 && fabs(o_r-o_b) < 7.65)
    }
    
    func with(minSaturation: Double) -> Double {
        // Ref: https://en.wikipedia.org/wiki/HSL_and_HSV
        
        // Convert RGB to HSV

        let _r = r/255
        let _g = g/255
        let _b = b/255
        var H, S, V: Double
        let M = fmax(_r,fmax(_g, _b))
        var C = M-fmin(_r,fmin(_g, _b))
        
        V = M
        S = V == 0 ? 0:C/V
        
        if minSaturation <= S {
            return self
        }
        
        if C == 0 {
            H = 0
        } else if _r == M {
            H = fmod((_g-_b)/C, 6)
        } else if _g == M {
            H = 2+((_b-_r)/C)
        } else {
            H = 4+((_r-_g)/C)
        }
        
        if H < 0 {
            H += 6
        }
        
        // Back to RGB
        
        C = V*minSaturation
        let X = C*(1-fabs(fmod(H,2)-1))
        var R, G, B: Double
        
        switch H {
        case 0...1:
            R = C
            G = X
            B = 0
        case 1...2:
            R = X
            G = C
            B = 0
        case 2...3:
            R = 0
            G = C
            B = X
        case 3...4:
            R = 0
            G = X
            B = C
        case 4...5:
            R = X
            G = 0
            B = C
        case 5..<6:
            R = C
            G = 0
            B = X
        default:
            R = 0
            G = 0
            B = 0
        }
        
        let m = V-C
        
        return (floor((R + m)*255)*1000000)+(floor((G + m)*255)*1000)+floor((B + m)*255)
    }
    
    func isContrasting(_ color: Double) -> Bool {
        let bgLum = (0.2126*r)+(0.7152*g)+(0.0722*b)+12.75
        let fgLum = (0.2126*color.r)+(0.7152*color.g)+(0.0722*color.b)+12.75
        if bgLum > fgLum {
            return 1.6 < bgLum/fgLum
        } else {
            return 1.6 < fgLum/bgLum
        }
    }
    
    var color: Color {
        #if os(macOS)
        return Color(NSColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1))
        #else
        return Color(UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1))
        #endif
    }
    
    var pretty: String {
        return "\(Int(self.r)), \(Int(self.g)), \(Int(self.b))"
    }
}

fileprivate struct NVMImageColorsCounter {
    let color: Double
    let count: Int
    init(color: Double, count: Int) {
        self.color = color
        self.count = count
    }
}

