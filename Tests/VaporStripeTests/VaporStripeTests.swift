//
// Created 1/21/2017
//

import XCTest
@testable import VaporStripe
import JSON
import HTTP

class VaporStripeTests: XCTestCase {            
    static let allTests = [
        ("testInitializer", testInitializer),
    ]
    
    func testInitializer() {
        let stripe = VaporStripe(apiKey: "apikey", token: "sometoken")
        
        XCTAssertEqual(stripe.apiKey, "apikey")
        XCTAssertEqual(stripe.token, "sometoken")
    }
}
