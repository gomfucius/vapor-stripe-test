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
        ("testResultInitializer", testResultInitializer),
    ]
    
    func testInitializer() {
        let stripe = VaporStripe(apiKey: "apikey", token: "sometoken")
        
        XCTAssertEqual(stripe.apiKey, "apikey")
        XCTAssertEqual(stripe.token, "sometoken")
    }
    
    func testResultInitializer() {
        do {
            let json = try JSON([
                "object": "charge",
                "amount": 50.makeNode()
                ])
            let result = Result(status: .success, headers: ["key": "value"], json: json)
            XCTAssertEqual(result.status, .success)
            XCTAssertEqual(result.headers["key"], "value")
            XCTAssertEqual(result.json?["object"]?.string, "charge")
            XCTAssertEqual(result.json?["amount"]?.int, 50)
        } catch {
            XCTAssert(false, "Failed test")
        }
    }
}
