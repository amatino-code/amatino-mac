//
//  SubscribeBillingCurrency.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class SubscribeBillingCurrency {
    
    
    let set = BillingCurrencySet(withCurrencies: [
        BillingCurrency(code: "USD", name: "U.S. Dollar", symbol: "$", countryNames: ["United States of America"]),
        BillingCurrency(code: "EUR", name: "Euro", symbol: "€", countryNames: [
            "France",
            "Germany",
            "Belgium"
            ]),
        BillingCurrency(code: "GBP", name: "Pounds Sterling", symbol: "£", countryNames: ["United Kingdom"]),
        BillingCurrency(code: "AUD", name: "Australian Dollar", symbol: "$", countryNames: ["Australia"]),
        BillingCurrency(code: "CAD", name: "Canadian Dollar", symbol: "$", countryNames: ["Australia"]),
        BillingCurrency(code: "NZD", name: "New Zealand Dollar", symbol: "$", countryNames: ["New Zealand"])])
    
}
