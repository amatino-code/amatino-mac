//
//  BillingPrice.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation

class BillingPrice {
    
    let currencyCode: String
    let magnitude: Decimal
    let symbol: String
    let basePriceString: String
    let formatter = NumberFormatter()
    
    init(currencyCode: String, magnitude: Decimal, symbol: String) {
        
        self.currencyCode = currencyCode
        self.magnitude = magnitude
        self.symbol = symbol
        
        formatter.minimumFractionDigits = 2

        basePriceString = symbol + formatter.string(from: magnitude as NSDecimalNumber)!
        
        return
    }
    
    func priceString(country: BillingCountry? = nil) -> String {
        
        if country == nil { return basePriceString }
        
        if country!.tax == nil { return basePriceString }
        
        let taxFactor = Decimal(1) + country!.tax!
        let adjustedMagnitude = magnitude * taxFactor
        
        let price = symbol + formatter.string(from: adjustedMagnitude as NSDecimalNumber)!
        return price
    }
    
    
}
