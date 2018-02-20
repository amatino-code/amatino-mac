//
//  BillingPlan.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation

class BillingPlan {
    
    let name: String
    let prices: [BillingPrice]
    let exposition: String
    
    init(name: String, exposition: String, terms: String, prices: [BillingPrice]) {

        self.name = name
        self.prices = prices
        self.exposition = exposition
        
        return
    }
    
    func priceForCurrencyWithCode(code: String, country: BillingCountry?) -> String {
        for price in prices {
            if price.currencyCode == code {
                return price.priceString(country: country)
            }
        }
        fatalError("Price cannot evaluate currency with code: \(code)")
    }
    
    func nameFor(country: BillingCountry, currency: BillingCurrency) -> String {
        
        let price = priceForCurrencyWithCode(code: currency.code, country: country)
        return name + ": " + price + " " + exposition
        
    }
}

extension BillingPlan: CustomStringConvertible {
    
    var description: String {
        get {
            return self.name
        }
    }
    
}
