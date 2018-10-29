//
//  BillingCurrency.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation

class BillingCurrency {
    
    let associatedCountryNames: [String]?
    let code: String
    let symbol: String
    let name: String
    
    init(code: String, name: String, symbol: String, countryNames: [String]?) {
        
        guard code.count == 3 else {
            fatalError("Invalid currency code: \(code)")
        }
        guard symbol.count == 1 else {
            fatalError("Invalid symbol: \(symbol)")
        }
        
        associatedCountryNames = countryNames
        self.name = name
        self.symbol = symbol
        self.code = code

    }
    
    func associatesWithCountry(_ country: BillingCountry) -> Bool {

        guard associatedCountryNames != nil else { return false }
        
        for name in associatedCountryNames! {
            if country.name == name { return true }
        }
        
        return false
    }
}

extension BillingCurrency: CustomStringConvertible {
    
    var description: String {
        get {
            return self.name
        }
    }
}
