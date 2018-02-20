//
//  BillingCurrencySet.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation

class BillingCurrencySet {
    
    let currencies: [BillingCurrency]
    let stringList: [String]
    let count: Int
    
    init(withCurrencies: [BillingCurrency]) {
        
        currencies = withCurrencies
        var workingList = [String]()
        for currency in currencies {
            workingList.append(String(describing: currency))
        }
        stringList = workingList
        count = stringList.count
        
        return
    }
    
    func currencyWithName(name: String?) -> BillingCurrency? {
        
        guard name != nil else { return nil }
        
        for currency in currencies {
            if currency.name == name {
                return currency
            }
        }
        
        fatalError("Attempt to retrieve non-existent currency with name: \(String(describing: name))")
        
    }
    
    func currencyWithCode(code: String?) -> BillingCurrency? {
        
        guard code != nil else { return nil }
        
        for currency in currencies {
            if currency.code == code {
                return currency
            }
        }
        fatalError("Attempt to retrieve non-existent currency with name: \(String(describing: code))")
    }
    
    func contains(currencyWithName name: String) -> Bool {
        return stringList.contains(name)
    }

    func currencyAssociatedWith(country: BillingCountry) -> BillingCurrency? {
        
        for currency in currencies {
            if currency.associatesWithCountry(country) {
                return currency
            }
        }
        
        return nil
        
    }
    
}
