//
//  SubscriptionRequest.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation

class SubscriptionRequest {
    
    private let agent = "Amatino MacOS"
    
    #if DEBUG
    private let subscribeUrl = URL(string: "http://127.0.0.1:5020/subscribe")!
    #else
    private let subscribeUrl = URL(string: "https://amatino.io/subscribe")!
    #endif
    private let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
    private let method = "POST"
    private let encoder = JSONEncoder()
    private let encodedData: Data
    
    private(set) var readyCallback: (() -> Void)? = nil

    private(set) var data: Data? = nil
    private(set) var response: URLResponse? = nil
    private(set) var error: Error? = nil
    private(set) var attributes: SubscriptionRequestAttributes
 
    let email: String

    init(
        country: BillingCountry,
        currency: BillingCurrency,
        plan: BillingPlan,
        email: String,
        passphrase: String,
        token: StripeToken
        ) {
    
        self.email = email
        
        attributes = SubscriptionRequestAttributes(
            email: email, passphrase: passphrase, plan: plan, country: country,
            currency: currency, stripeToken: token)
        
        let encodingAttempt = try? encoder.encode(attributes)
        guard encodingAttempt != nil else {fatalError("Subscription request data encoding failed")}
        encodedData = encodingAttempt!
        
        var request = URLRequest(url: subscribeUrl)
        request.httpMethod = method
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpBody = encodedData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(agent, forHTTPHeaderField: "User-Agent")
        
        let task = session.dataTask(with: request, completionHandler: self.processCompletion)
        task.resume()
        
        return
    }
    
    private func processCompletion(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
        if readyCallback != nil {
            _ = readyCallback!()
        }
        return
    }
    
    func setCallback(_ callback: @escaping () -> Void) -> Bool {
        
        readyCallback = callback
        
        if response != nil {
            return true
        }
        
        return false
    }
}
