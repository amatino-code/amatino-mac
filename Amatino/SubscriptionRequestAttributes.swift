//
//  SubscriptionRequestAttributes.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation

struct SubscriptionRequestAttributes: Encodable {
    
    let email: String
    let passphrase: String
    let tokenId: String
    let billingPlanName: String
    let billingCountryName: String
    let billingCurrencyCode: String
    
    init (
        email: String,
        passphrase: String,
        plan: BillingPlan,
        country: BillingCountry,
        currency: BillingCurrency,
        stripeToken: StripeToken
        ) {
        
        self.email = email
        self.passphrase = passphrase
        billingPlanName = String(describing: plan)
        billingCountryName = String(describing: country)
        billingCurrencyCode = currency.code
        tokenId = String(describing: stripeToken)
        
    }
    
    enum CodingKeys: String, CodingKey {
        case email
        case passphrase = "secret"
        case tokenId = "token_id"
        case billingPlanName = "plan"
        case billingCountryName = "billing_country"
        case billingCurrencyCode = "billing_currency"
    }
    
}

let
