//
// Created 1/21/2017
//

@testable import VaporStripe

import XCTest
import JSON
import HTTP

class VaporStripeTests: XCTestCase {
    
    let vaporStripe: VaporStripe! = nil
    
    override func setUp() {
        
    }
    
    func testCharge() throws {
        
        XCTAssertEqual("testdayo", "testdayo")
    }
//    
//    func testLoadPrivateKey() throws {
//        var filepath = ""
//        let fileManager = FileManager.default
//        
//        #if os(Linux)
//            filepath = fileManager.currentDirectoryPath.appending("/Tests/VaporAPNSTests/TestAPNSAuthKey.p8")
//        #else
//        if let filepathe = Bundle.init(for: type(of: self)).path(forResource: "TestAPNSAuthKey", ofType: "p8") {
//            filepath = filepathe
//        }else {
//            filepath = fileManager.currentDirectoryPath.appending("/Tests/VaporAPNSTests/TestAPNSAuthKey.p8")
//        }
//        #endif
//        print (filepath)
//        
//        if fileManager.fileExists(atPath: filepath) {
//        let (privKey, pubKey) = try filepath.tokenString()
//            XCTAssertEqual(privKey, "ALEILVyGWnbBaSaIFDsh0yoZaK+Ej0po/55jG2FR6u6C")
//            XCTAssertEqual(pubKey, "BKqKwB6hpXp9SzWGt3YxnHgCEkcbS+JSrhoqkeqru/Nf62MeE958RIiKYsLFA/czdE7ThCt46azneU0IBnMCuQU=")
//        } else {
//            XCTFail("APNS Authentication key not found!")
//        }
//    }
//    
//    func testEncoding() throws {
//        let jwt = try! JWT(
//            additionalHeaders: [KeyID("E811E6AE22")],
//            payload: Node([IssuerClaim("D86BEC0E8B"), IssuedAtClaim()]),
//            signer: ES256(encodedKey: "ALEILVyGWnbBaSaIFDsh0yoZaK+Ej0po/55jG2FR6u6C"))
//
//        let tokenString = try! jwt.createToken()
//
//        do {
//            let jwt2 = try JWT(token: tokenString)
//            let verified = try jwt2.verifySignatureWith(ES256(encodedKey: "BKqKwB6hpXp9SzWGt3YxnHgCEkcbS+JSrhoqkeqru/Nf62MeE958RIiKYsLFA/czdE7ThCt46azneU0IBnMCuQU="))
//            XCTAssertTrue(verified)
//        } catch {
//            print(error)
//            XCTFail("Couldn't verify token")
//        }
//    }
    
    static var allTests : [(String, (VaporAPNSTests) -> () throws -> Void)] {
        return [
            ("testCharge", testCharge),
        ]
    }
}
