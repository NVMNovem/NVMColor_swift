import XCTest
@testable import NVMColor

final class NVMColorTests: XCTestCase {
    func testCleanedHex() throws {
        XCTAssertEqual("#FG25DF".cleanedHex, "FG25DF", "Cleaned Hex failed: \("#FG25DF".cleanedHex)")
        XCTAssertEqual("#DfkF5e".cleanedHex, "DFKF5E", "Cleaned Hex failed: \("#DfkF5e".cleanedHex)")
        XCTAssertEqual("#.47Ef2B".cleanedHex, "47EF2B", "Cleaned Hex failed: \("#.47Ef2B".cleanedHex)")
        XCTAssertEqual("RFJDL4".cleanedHex, "RFJDL4", "Cleaned Hex failed: \("RFJDL4".cleanedHex)")
        XCTAssertEqual("8d7C4ã".cleanedHex, "8D7C4A", "Cleaned Hex failed: \("8d7C4ã".cleanedHex)")
    }
}
