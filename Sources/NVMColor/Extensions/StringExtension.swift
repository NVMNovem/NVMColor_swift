//
//  StringExtension.swift
//  
//
//  Created by Damian Van de Kauter on 13/11/2021.
//

import Foundation

extension String {
    public func isHex() -> Bool {
        if self.contains("#") {
            if ((self.cleanedHex.count == 6) || (self.cleanedHex.count == 8)) {
                return true
            } else {
                return false
            }
        } else {
            if ((self.count == 6 || self.count == 8) && self.isAlphanumeric()) {
                return true
            } else {
                return false
            }
        }
    }
    
    /**
     This function will check if the String is a hex and return an alphanumeric string of the hex back.
     This is the hex without special characters.
     */
    public func isHex() -> String? {
        if self.isHex() {
            return self.cleanedHex()
        } else {
            return nil
        }
    }
    
    public var cleanedHex -> String {
        return self.filter("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".contains)
    }
}

extension String {
    internal func isAlphanumeric() -> Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
