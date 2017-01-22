//
// Created 1/21/2017
//

import XCTest
@testable import VaporStripe
import JSON
import HTTP

class VaporStripeTests: XCTestCase
{            
    static let allTests = [
        ("testInitializer", testInitializer),
    ]
    
    func testInitializer() 
    {
        let stripe = VaporStripe(apiKey: "apikey", token: "sometoken", amount: 99, currency: .usd, description: "Some description")
        
        XCTAssertEqual(stripe.apiKey, "apikey")
        XCTAssertEqual(stripe.token, "sometoken")
        XCTAssertEqual(stripe.amount, 99)
        XCTAssertEqual(stripe.currency, .usd)
        XCTAssertEqual(stripe.currency.rawValue, "usd")
        XCTAssertEqual(stripe.description, "Some description")
    }
}
