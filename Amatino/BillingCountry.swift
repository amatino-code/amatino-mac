//
//  BillingCountry.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//


import Foundation

class BillingCountry: CustomStringConvertible {
    
    let name: String
    let id: Int
    let tax: Decimal?
    var description: String {
        get {
            return name
        }
    }
    
    init(_ name: String, _ id: Int, _ taxFactor: Decimal? = nil) {
        self.name = name
        self.id = id
        self.tax = taxFactor
    }

}
