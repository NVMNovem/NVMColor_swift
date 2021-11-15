//
//  StringExtension.swift
//  
//
//  Created by Damian Van de Kauter on 13/11/2021.
//

import Foundation

extension String {
    
    /**
     This function will check if the String is a hex.
     
     - warning: This doesn't validate wheter or not this is an actual valid color.
     */
    public func isHex() -> Bool {
        if (((self.cleanedHex.count == 6) || (self.cleanedHex.count == 8)) && (self.replacingOccurrences(of: "#", with: "").isAlphanumeric())) {
            return true
        } else {
            return false
        }
    }
    
    /**
     This function will check if the String is a hex and return an alphanumeric string of the hex back.
     This is the hex without special characters.
     */
    public func isHex() -> String? {
        if self.isHex() {
            return self.cleanedHex
        } else {
            return nil
        }
    }
    
    /**
     This variable will return you a cleaned **hex** of the given `String`.
     
     - returns: An alphanumeric `String`.
     
     - note: This will remove the "#" from the string.
     */
    public var cleanedHex: String {
        return self.replacingOccurrences(of: "#", with: "").trimmingCharacters(in: CharacterSet.alphanumerics.inverted).cleanedString.uppercased()
    }
}

extension String {
    
    internal func isAlphanumeric() -> Bool {
        return ((!self.isEmpty) && (self.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil))
    }
    
    internal var cleanedString: String {
        var cleanedString = self
        
        cleanedString = cleanedString.replacingOccurrences(of: "á", with: "a")
        cleanedString = cleanedString.replacingOccurrences(of: "ä", with: "a")
        cleanedString = cleanedString.replacingOccurrences(of: "â", with: "a")
        cleanedString = cleanedString.replacingOccurrences(of: "à", with: "a")
        cleanedString = cleanedString.replacingOccurrences(of: "æ", with: "a")
        cleanedString = cleanedString.replacingOccurrences(of: "ã", with: "a")
        cleanedString = cleanedString.replacingOccurrences(of: "å", with: "a")
        cleanedString = cleanedString.replacingOccurrences(of: "ā", with: "a")
        cleanedString = cleanedString.replacingOccurrences(of: "ç", with: "c")
        cleanedString = cleanedString.replacingOccurrences(of: "é", with: "e")
        cleanedString = cleanedString.replacingOccurrences(of: "ë", with: "e")
        cleanedString = cleanedString.replacingOccurrences(of: "ê", with: "e")
        cleanedString = cleanedString.replacingOccurrences(of: "è", with: "e")
        cleanedString = cleanedString.replacingOccurrences(of: "ę", with: "e")
        cleanedString = cleanedString.replacingOccurrences(of: "ė", with: "e")
        cleanedString = cleanedString.replacingOccurrences(of: "ē", with: "e")
        cleanedString = cleanedString.replacingOccurrences(of: "í", with: "i")
        cleanedString = cleanedString.replacingOccurrences(of: "ï", with: "i")
        cleanedString = cleanedString.replacingOccurrences(of: "ì", with: "i")
        cleanedString = cleanedString.replacingOccurrences(of: "î", with: "i")
        cleanedString = cleanedString.replacingOccurrences(of: "į", with: "i")
        cleanedString = cleanedString.replacingOccurrences(of: "ī", with: "i")
        cleanedString = cleanedString.replacingOccurrences(of: "j́", with: "j")
        cleanedString = cleanedString.replacingOccurrences(of: "ñ", with: "n")
        cleanedString = cleanedString.replacingOccurrences(of: "ń", with: "n")
        cleanedString = cleanedString.replacingOccurrences(of: "ó", with: "o")
        cleanedString = cleanedString.replacingOccurrences(of: "ö", with: "o")
        cleanedString = cleanedString.replacingOccurrences(of: "ô", with: "o")
        cleanedString = cleanedString.replacingOccurrences(of: "ò", with: "o")
        cleanedString = cleanedString.replacingOccurrences(of: "õ", with: "o")
        cleanedString = cleanedString.replacingOccurrences(of: "œ", with: "o")
        cleanedString = cleanedString.replacingOccurrences(of: "ø", with: "o")
        cleanedString = cleanedString.replacingOccurrences(of: "ō", with: "o")
        cleanedString = cleanedString.replacingOccurrences(of: "ú", with: "u")
        cleanedString = cleanedString.replacingOccurrences(of: "ü", with: "u")
        cleanedString = cleanedString.replacingOccurrences(of: "û", with: "u")
        cleanedString = cleanedString.replacingOccurrences(of: "ù", with: "u")
        cleanedString = cleanedString.replacingOccurrences(of: "ū", with: "u")
        
        return cleanedString
    }
}
