import Foundation
import JSON
import HTTP

public enum Currency: String {
    case aud = "aud"
    case cad = "cad"
    case dkk = "dkk"
    case eur = "eur"
    case gpd = "gpd"
    case jpy = "jpy"
    case nok = "nok"
    case usd = "usd"
    case sek = "sek"
    case sgd = "sgd"
}

public final class VaporStripe {
    let apiHostUrl = "https://api.stripe.com"
    let apiVersion = "v1"
    let chargePath = "charges"
    let apiKey: String
    let token: String
    
    public init(apiKey: String, token: String) {
        self.apiKey = apiKey
        self.token = token
    }
    
    public func charge(amount: Int, currency: Currency, description: String) throws -> Result {
        let dictionary = [
            "amount": try amount.makeNode(),
            "currency": currency.rawValue.makeNode(),
            "description": description.makeNode(),
            "source": token.makeNode()
        ]
        
        let node = Node(dictionary)
        let response = try BasicClient.post("\(apiHostUrl)/\(apiVersion)/\(chargePath)", headers: ["Authorization": "Bearer \(apiKey)"], body: Body.data(node.vsFormURLEncoded()))
        
        var json: JSON?
        if let bytes = response.body.bytes {
            json = try JSON(bytes: bytes) 
        }
        
        return Result(status: ResponseStatus(statusCode: response.status.statusCode), headers: response.headers, json: json)        
    }
}

// Taken from StructuredData+FormURLEncoded.swift.
// TODO: Figure out how to use it without having to `import Vapor`
extension Node {
    fileprivate func vsFormURLEncoded() throws -> Bytes {
        guard case .object(let dict) = self else {
            return []
        }
        
        var bytes: [[Byte]] = []
        
        for (key, val) in dict {
            var subbytes: [Byte] = []
            subbytes += try percentEncoded(key.bytes)
            subbytes += Byte.equals
            subbytes += try percentEncoded(val.string?.bytes ?? [])
            bytes.append(subbytes)
        }
        
        return bytes.joined(separator: [Byte.ampersand]).array
    }
}

public struct Result {
    public let status: ResponseStatus
    public let headers: [HTTP.HeaderKey: String]
    public let json: JSON?
    
    public init(status: ResponseStatus, headers: [HTTP.HeaderKey: String], json: JSON?) {
        self.status = status
        self.headers = headers
        self.json = json
    }
}

/// https://stripe.com/docs/api/curl#errors
public enum ResponseStatus: Int {
    case success
    case badRequest
    case unauthorized
    case requestFailed
    case notFound
    case conflict
    case tooManyRequests
    case serverError
    
    public init(statusCode: Int) {
        switch statusCode {
        case 200:
            self = .success
        case 400:
            self = .badRequest    
        case 401:
            self = .unauthorized
        case 402:
            self = .requestFailed
        case 404:
            self = .notFound
        case 409:
            self = .conflict
        case 429:
            self = .tooManyRequests
        case 500, 502, 503, 504:
            self = .serverError
        default:
            self = .badRequest
        }
    }
}
