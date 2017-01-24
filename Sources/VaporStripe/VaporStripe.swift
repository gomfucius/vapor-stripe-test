import Foundation
import JSON
import HTTP

public enum Currency: String 
{
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

public final class VaporStripe
{
    let apiHostUrl = "https://api.stripe.com"
    let apiVersion = "v1"
    let chargePath = "charges"
    let apiKey: String
    let amount: Int
    let currency: Currency
    let description: String
    let token: String
    
    public init(apiKey: String, token: String, amount: Int, currency: Currency, description: String) 
    {
        self.apiKey = apiKey
        self.amount = amount
        self.currency = currency
        self.description = description
        self.token = token
    }
    
    public func charge() throws -> Response
    {
        let dictionary = [
            "amount": try amount.makeNode(),
            "currency": currency.rawValue.makeNode(),
            "description": description.makeNode(),
            "source": token.makeNode()
        ]
        
        let node = Node(dictionary)
        return try BasicClient.post("\(apiHostUrl)/\(apiVersion)/\(chargePath)", headers: ["Authorization": "Bearer \(apiKey)"], body: Body.data(node.vsFormURLEncoded()))  
    }
}

extension Node 
{
    fileprivate func vsFormURLEncoded() throws -> Bytes 
    {
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
