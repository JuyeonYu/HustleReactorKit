import XCTest
import MyLibrary

    final class BoolInitTestCase: XCTestCase {
        func test_Bool_init_validBits() throws {
            if let boolFromTrueBit = Bool(bit: 1) {
                XCTAssertTrue(boolFromTrueBit)
            } else {
                XCTFail()
            }
            let boolFromFalseBit = try XCTUnwrap(Bool(bit: 0))
            XCTAssertFalse(boolFromFalseBit)
        }
        func test_Bool_init_invalidBits() {
            XCTAssertNil(Bool(bit: 2))
            XCTAssertNil(Bool(bit: -1))
        }
    }
