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
        ("testCharge", testCharge),
        ("testResponseStatusInitializer", testResponseStatusInitializer),
        ("testVsFormEncoded", testVsFormEncoded),
    ]
    
    func testInitializer() {
        let stripe = VaporStripe(apiKey: "apikey", token: "sometoken")
        
        XCTAssertEqual(stripe.apiKey, "apikey")
        XCTAssertEqual(stripe.token, "sometoken")
    }
    
    func testResultInitializer() throws {
        let json = try JSON(node: [
            "object": "charge",
            "amount": 50.makeNode()
            ])
        
        let result = Result(status: .success, headers: ["key": "value"], json: json)
        XCTAssertEqual(result.status, .success)
        XCTAssertEqual(result.headers["key"], "value")
        XCTAssertEqual(result.json?["object"]?.string, "charge")
        XCTAssertEqual(result.json?["amount"]?.int, 50)
    }
    
    func testCharge() throws {
        let stripe = VaporStripe(apiKey: "apikey", token: "sometoken")
        let result = try stripe.charge(amount: 1, currency: .usd, description: "unit test")
        XCTAssertEqual(result.status, .unauthorized)
    }
    
    func testResponseStatusInitializer() {
        let responseStatus1 = ResponseStatus(statusCode: 200)
        XCTAssertEqual(responseStatus1, .success)
        let responseStatus2 = ResponseStatus(statusCode: 400)
        XCTAssertEqual(responseStatus2, .badRequest)
        let responseStatus3 = ResponseStatus(statusCode: 401)
        XCTAssertEqual(responseStatus3, .unauthorized)
        let responseStatus4 = ResponseStatus(statusCode: 402)
        XCTAssertEqual(responseStatus4, .requestFailed)
        let responseStatus5 = ResponseStatus(statusCode: 404)
        XCTAssertEqual(responseStatus5, .notFound)
        let responseStatus6 = ResponseStatus(statusCode: 409)
        XCTAssertEqual(responseStatus6, .conflict)
        let responseStatus7 = ResponseStatus(statusCode: 429)
        XCTAssertEqual(responseStatus7, .tooManyRequests)
        let responseStatus8 = ResponseStatus(statusCode: 500)
        XCTAssertEqual(responseStatus8, .serverError)
        let responseStatus9 = ResponseStatus(statusCode: 502)
        XCTAssertEqual(responseStatus9, .serverError)
        let responseStatus10 = ResponseStatus(statusCode: 503)
        XCTAssertEqual(responseStatus10, .serverError)
        let responseStatus11 = ResponseStatus(statusCode: 504)
        XCTAssertEqual(responseStatus11, .serverError)
    }
    
    func testVsFormEncoded() throws {
        let dictionary = [
            "amount": try 10.makeNode()
        ]
        
        let node = Node(dictionary)
        let bytesString = try node.vsFormURLEncoded().string()
        XCTAssertEqual(bytesString, "%61%6d%6f%75%6e%74=%31%30")
    }
}
