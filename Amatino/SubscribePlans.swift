//
//  SubscribePlans.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation

class SubscribePlans {
    
    let planSet = BillingPlanSet(plans: [
        BillingPlan(
            name: "Individual",
            exposition: "/ month",
            terms: """
                You can cancel or change plans at any time, and your
                first two weeks are on the house.
            """,
            prices: [
                BillingPrice(currencyCode: "USD", magnitude: 3.00, symbol: "$"),
                BillingPrice(currencyCode: "EUR", magnitude: 2.60, symbol: "€"),
                BillingPrice(currencyCode: "GBP", magnitude: 2.30, symbol: "£"),
                BillingPrice(currencyCode: "AUD", magnitude: 4.00, symbol: "$"),
                BillingPrice(currencyCode: "CAD", magnitude: 3.85, symbol: "$"),
                BillingPrice(currencyCode: "NZD", magnitude: 4.40, symbol: "$")
            ]
        ),
        BillingPlan(
            name: "Business",
            exposition: "/ month / user",
            terms: """
                You can cancel or change plans at any time, and your first
                user gets two weeks usage on the house.
            """,
            prices: [
                BillingPrice(currencyCode: "USD", magnitude: 3.00, symbol: "$"),
                BillingPrice(currencyCode: "EUR", magnitude: 2.60, symbol: "€"),
                BillingPrice(currencyCode: "GBP", magnitude: 2.30, symbol: "£"),
                BillingPrice(currencyCode: "AUD", magnitude: 4.00, symbol: "$"),
                BillingPrice(currencyCode: "CAD", magnitude: 3.85, symbol: "$"),
                BillingPrice(currencyCode: "NZD", magnitude: 4.40, symbol: "$")
            ]
        ),
        BillingPlan(
            name: "Developer",
            exposition: "/ month / typical user",
            terms: """
                You can cancel or change plans at any time, and two weeks worth
                of usage for one typical user are on the house.
            """,
            prices: [
                BillingPrice(currencyCode: "USD", magnitude: 3.00, symbol: "$"),
                BillingPrice(currencyCode: "EUR", magnitude: 2.60, symbol: "€"),
                BillingPrice(currencyCode: "GBP", magnitude: 2.30, symbol: "£"),
                BillingPrice(currencyCode: "AUD", magnitude: 4.00, symbol: "$"),
                BillingPrice(currencyCode: "CAD", magnitude: 3.85, symbol: "$"),
                BillingPrice(currencyCode: "NZD", magnitude: 4.40, symbol: "$")
            ]
        )
    ])
    
    func namesFor(country: BillingCountry?, currency: BillingCurrency?) -> [String] {
        
        if country == nil || currency == nil {
            return planSet.rawNames
        }
        
        return planSet.namesFor(country: country!, currency: currency!)
    }
}
