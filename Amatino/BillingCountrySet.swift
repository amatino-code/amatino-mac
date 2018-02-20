//
//  BillingCountrySet.swift
//  Amatino
//
//  Created by Hugh Jeremy on 14/2/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation

class BillingCountrySet {
    
    let countries: [BillingCountry]
    let stringList: [String]
    let count: Int
    
    init(_ countries: [BillingCountry]) {
        self.countries = countries
        var workingList = [String]()
        for country in countries {
            workingList.append(String(describing: country))
        }
        stringList = workingList
        count = countries.count
    }
    
    func countryWithName(fromString name: String?) -> BillingCountry? {
        guard name != nil else { return nil }
        for country in countries {
            if country.name == name { return country }
        }
        return nil
    }
    
    func contains(countryWithName name: String) -> Bool {
        return stringList.contains(name)
    }
    
}
