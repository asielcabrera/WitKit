import XCTest
@testable import WitKit

final class WitKitTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        curl \
//        -H 'Authorization: Bearer ' \
//        'https://api.wit.ai/message?v=20211206&q='
         
        XCTAssertEqual(WitKit().text, "Hello, World!")
    }
}
