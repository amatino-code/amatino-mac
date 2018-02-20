//
//  StripeToken.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation

enum InvalidStripeResponse: Error {
    case MissingId
}

struct StripeToken {
    
    private let token: String
    
    init(rawStripeData: [String: Any?]) throws {
        
        let root = rawStripeData["token"] as? [String: Any?]
        let tokenCast = root?["id"] as? String
        guard tokenCast != nil else { throw InvalidStripeResponse.MissingId }
        token = tokenCast!
        
    }
    
}


extension StripeToken: CustomStringConvertible {
    
    var description: String {
        get {
            return token
        }
    }
    
}
