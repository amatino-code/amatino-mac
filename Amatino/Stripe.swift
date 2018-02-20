//
//  Stripe.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//


import Foundation
import WebKit

enum JsMessages: String {
    
    case cardError = "cardError"
    case clearCardError = "clearCardError"
    case tokenReady = "tokenReady"
    
}

class Stripe {
    
    let webView: WKWebView
    let contentControl: WKUserContentController
    let errorText: NSTextField
    
    private let startingErrorText = ""
    private let execution = "createToken()"
    
    private var tokenCallback: (([String: Any]) -> Void)? = nil
    
    #if DEBUG
    private let stripeUrl = Bundle.main.url(forResource: "CardInput", withExtension: "html")
    #else
    private let stripeUrl = Bundle.main.url(forResource: "CardInput", withExtension: "html")
    #endif
    
    init(webView: WKWebView, view: WelcomeCreateAccount, errorText: NSTextField) {

        self.webView = webView
        self.errorText = errorText
        
        self.errorText.stringValue = startingErrorText
        
        contentControl = WKUserContentController()
        
        self.webView.configuration.userContentController.add(view, name: JsMessages.cardError.rawValue)
        self.webView.configuration.userContentController.add(view, name: JsMessages.clearCardError.rawValue)
        self.webView.configuration.userContentController.add(view, name: JsMessages.tokenReady.rawValue)
    
        let request = URLRequest(url: stripeUrl!)
        self.webView.load(request)

    }
    
    func processMessage(name: String, body: Any) {
        
        switch JsMessages(rawValue: name) {
        case .cardError?:
            errorText.stringValue = body as! String
        case .clearCardError?:
            errorText.stringValue = ""
        case .tokenReady?:
            guard tokenCallback != nil else {fatalError("Token returned before callback set")}
            tokenCallback!(body as! [String: Any])
        default:
            fatalError("Unknown JsMessage case")
        }
    }
    
    func requestToken(tokenCallback: @escaping ([String: Any]) -> Void) {
        self.tokenCallback = tokenCallback
        webView.evaluateJavaScript(execution, completionHandler: nil)
        return
    }
}
