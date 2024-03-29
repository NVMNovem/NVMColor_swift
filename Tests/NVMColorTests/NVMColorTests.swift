import XCTest
import SwiftUI
@testable import NVMColor

final class NVMColorTests: XCTestCase {
    @Environment(\.colorScheme) private var colorScheme
    
    func testCleanedHex() throws {
        XCTAssertEqual("#FG25DF".cleanedHex, "FG25DF", "Cleaned Hex failed: \("#FG25DF".cleanedHex)")
        XCTAssertEqual("#DfkF5e".cleanedHex, "DFKF5E", "Cleaned Hex failed: \("#DfkF5e".cleanedHex)")
        XCTAssertEqual("#.47Ef2B".cleanedHex, "47EF2B", "Cleaned Hex failed: \("#.47Ef2B".cleanedHex)")
        XCTAssertEqual("RFJDL4".cleanedHex, "RFJDL4", "Cleaned Hex failed: \("RFJDL4".cleanedHex)")
        XCTAssertEqual("8d7C4ã".cleanedHex, "8D7C4A", "Cleaned Hex failed: \("8d7C4ã".cleanedHex)")
    }
    
    @available(iOS 14.0, *)
    @available(watchOS 7.0, *)
    func testColorComparison() throws {
        XCTAssertTrue(Color.green.isEqual(to: Color.green))
        XCTAssertTrue(Color.white.isEqual(to: Color.white))
        XCTAssertTrue(Color.white.isEqual(to: Color(hex: "FFFFFF")!))
        XCTAssertTrue(Color.black.isEqual(to: Color.black))
        XCTAssertTrue(Color.black.isEqual(to: Color(hex: "000000")!))
    }
    @available(iOS 14.0, *)
    @available(watchOS 7.0, *)
    func testColorComparisonWithTolerance() throws {
        XCTAssertTrue(Color.green.isEqual(to: Color.green, tolerance: 0.1))
        XCTAssertTrue(Color.white.isEqual(to: Color.white, tolerance: 0.1))
        XCTAssertTrue(Color.white.isEqual(to: Color(hex: "FFFFFF")!, tolerance: 0.1))
        XCTAssertTrue(Color.black.isEqual(to: Color.black, tolerance: 0.1))
        XCTAssertTrue(Color.black.isEqual(to: Color(hex: "000000")!, tolerance: 0.1))
    }
    @available(iOS 14.0, *)
    @available(watchOS 7.0, *)
    func testColorComparisonFalse() throws {
        XCTAssertFalse(Color.green.isEqual(to: Color.red))
        XCTAssertFalse(Color.white.isEqual(to: Color.black))
        XCTAssertFalse(Color.white.isEqual(to: Color(hex: "000000")!))
        XCTAssertFalse(Color.black.isEqual(to: Color.white))
        XCTAssertFalse(Color.black.isEqual(to: Color(hex: "FFFFFF")!))
    }
    @available(iOS 14.0, *)
    @available(watchOS 7.0, *)
    func testColorComparisonFalseWithTolerance() throws {
        XCTAssertFalse(Color.green.isEqual(to: Color.red, tolerance: 0.1))
        XCTAssertFalse(Color.white.isEqual(to: Color.black, tolerance: 0.1))
        XCTAssertFalse(Color.white.isEqual(to: Color(hex: "000000")!, tolerance: 0.1))
        XCTAssertFalse(Color.black.isEqual(to: Color.white, tolerance: 0.1))
        XCTAssertFalse(Color.black.isEqual(to: Color(hex: "FFFFFF")!, tolerance: 0.1))
    }
    @available(iOS 14.0, *)
    @available(watchOS 7.0, *)
    func testOpacicty() throws {
        let testColor = Color(.sRGB, red: 0.5, green: 0.3, blue: 0.1, opacity: 0.75)
        XCTAssertTrue(testColor.isEqual(to: Color(hex: "804C19BF")!, tolerance: 0.1))
    }
    
    @available(iOS 14.0, *)
    @available(watchOS 7.0, *)
    func testThemedColor() throws {
        XCTAssertEqual(Color.red.themedColor(colorScheme), Color.red)
    }
    @available(iOS 14.0, *)
    @available(watchOS 7.0, *)
    func testThemedColor2() throws {
        if colorScheme == .dark {
            XCTAssertEqual(Color(hex: "2E3240")!.themedColor(colorScheme, tolerance: 0.3), Color.primary)
        } else {
            XCTAssertEqual(Color(hex: "D1CBC1")!.themedColor(colorScheme, tolerance: 0.3), Color.primary)
        }
    }
    @available(iOS 14.0, *)
    @available(watchOS 7.0, *)
    func testThemedColor3() throws {
        let replacingColor = Color.green
        if colorScheme == .dark {
            XCTAssertEqual(Color(hex: "2E3240")!.themedColor(colorScheme, replacingColor: replacingColor, tolerance: 0.3), replacingColor)
        } else {
            XCTAssertEqual(Color(hex: "D1CBC1")!.themedColor(colorScheme, replacingColor: replacingColor, tolerance: 0.3), replacingColor)
        }
    }
}
