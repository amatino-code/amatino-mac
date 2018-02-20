//
//  WelcomeCreateAccount.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
import WebKit

protocol SubscriptionComboBox: SubscribeValidity {}

class WelcomeCreateAccount: NSViewController {
    
    #if DEBUG
    private let urlTermsAndConditions = URL(string: "http://127.0.0.1:5020/terms-of-use")!
    private let urlPrivacyPolicy = URL(string: "http://127.0.0.1:5020/privacy-policy")!
    private let urlOfferDetails = URL(string: "http://127.0.0.1:5020/offer-details")!
    #else
    private let urlTermsAndConditions = URL(string: "https://amatino.io/terms-of-use")!
    private let urlPrivacyPolicy = URL(string: "https://amatino.io/privacy-policy")!
    private let urlOfferDetails = URL(string: "https://amatino.io/offer-details")!
    #endif
    
    @IBOutlet weak var stripeWebView: WKWebView!
    @IBOutlet weak var stripeCardErrorText: NSTextField!
    
    @IBOutlet weak var subscribeButton: TextButton!
    @IBOutlet weak var subscribeProgressSpinner: NSProgressIndicator!
    
    // Form fields
    @IBOutlet weak var subscribeEmail: SubscribeEmail!
    @IBOutlet weak var subscribeEmailError: NSTextField!
    @IBOutlet weak var subscribePassphrase: SubscribePassphrase!
    @IBOutlet weak var subscribePassphraseError: NSTextField!
    @IBOutlet weak var subscribePassphraseConfirm: SubscribePassphraseConfirm!
    @IBOutlet weak var subscribePassphraseConfirmError: NSTextField!
    @IBOutlet weak var subscribeBillingCountry: NSPopUpButton!
    @IBOutlet weak var subscribeBillingCurrency: NSPopUpButton!
    @IBOutlet weak var subscribePlanSelection: NSPopUpButton!
    @IBOutlet weak var subscribeLegalAcceptance: NSButton!
    
    var stripe: Stripe? = nil
    var prePopulationAttributes: SubscriptionRequestAttributes? = nil
    let plans = SubscribePlans()
    let countries = SubscribeBillingCountry()
    let currencies = SubscribeBillingCurrency()
    
    private var request: SubscriptionRequest? = nil
    
    override func viewDidLoad() {

        stripe = Stripe(webView: stripeWebView, view: self, errorText: stripeCardErrorText)
        
        subscribeBillingCountry.removeAllItems()
        subscribeBillingCountry.addItems(withTitles: countries.set.stringList)
        subscribeBillingCountry.selectItem(withTitle: "United States of America")
        
        subscribeBillingCurrency.removeAllItems()
        subscribeBillingCurrency.addItems(withTitles: currencies.set.stringList)
        subscribeBillingCurrency.selectItem(withTitle: "U.S. Dollar")
        
        populatePlanList()
        
        subscribeEmail.errorText = subscribeEmailError
        subscribePassphrase.errorText = subscribePassphraseError
        subscribePassphraseConfirm.errorText = subscribePassphraseConfirmError
        
        subscribeEmail.clearError()
        subscribePassphrase.clearError()
        subscribePassphraseConfirm.clearError()
        
        subscribePassphraseConfirm.passphrase = subscribePassphrase
        
        if prePopulationAttributes != nil {
            prePopulateFields(prePopulationAttributes!)
        }
        
        return
    }
    
    func populateFields(attributes: SubscriptionRequestAttributes) {
        
        prePopulationAttributes = attributes
        return
    }
    
    func prePopulateFields(_ attributes: SubscriptionRequestAttributes) {

        subscribeBillingCountry.selectItem(withTitle: attributes.billingCountryName)
        let country = countries.set.countryWithName(fromString: attributes.billingCountryName)
        let currency = currencies.set.currencyWithCode(code: attributes.billingCurrencyCode)
        let plan = plans.planSet.planWithName(attributes.billingPlanName)
        guard country != nil else { fatalError("Unknown country name \(attributes.billingCountryName)") }
        guard currency != nil else { fatalError("Unknown currency code \(attributes.billingCurrencyCode)") }
        subscribeBillingCurrency.selectItem(withTitle: currency!.name)
        subscribePlanSelection.selectItem(withTitle: plan.nameFor(country: country!, currency: currency!))
        
        subscribeEmail.stringValue = attributes.email
        subscribePassphrase.stringValue = attributes.passphrase
        subscribePassphraseConfirm.stringValue = attributes.passphrase
        subscribeLegalAcceptance.state = .on
        
        return
    }

    private func populatePlanList() {
        
        let selectedCountry = countries.set.countryWithName(fromString: subscribeBillingCountry.titleOfSelectedItem)
        let selectedCurrency = currencies.set.currencyWithName(name: subscribeBillingCurrency.titleOfSelectedItem)
        
        let cachedIndex = subscribePlanSelection.indexOfSelectedItem
        subscribePlanSelection.removeAllItems()
        let titles = plans.namesFor(country: selectedCountry, currency: selectedCurrency)
        subscribePlanSelection.addItems(withTitles: titles)
        subscribePlanSelection.selectItem(at: cachedIndex)
        
        return
        
    }
    
    private func formIsValid() -> Bool {
        
        if !subscribeEmail.isValid() { return false }
        
        if !subscribePassphrase.isValid() { return false }
        
        if !subscribePassphraseConfirm.isValid() { return false }
        
        if subscribeLegalAcceptance.state != .on { return false }
        
        // We presume that card details are OK. (Ew!)
        // We presume that NSPopUpButtons have OK values.
        
        return true
    }
    
    private func updateSubscribeButtonState() {
        if formIsValid() { activateSubscriptionButton() } else { deactivateSubscriptionButton() }
        return
    }
    
    private func activateSubscriptionButton() {
        subscribeButton.showHighlightState()
        subscribeButton.isEnabled = true
    }
    
    private func deactivateSubscriptionButton() {
        subscribeButton.showStandardState()
        subscribeButton.isEnabled = false
    }
    
    private func processToken(token: [String: Any]) {

        let error = token["error"] as? [String: Any]
        let message = error?["message"] as? String
        
        if message != nil {
            stripeCardErrorText.stringValue = message!
            subscribeButton.isHidden = false
            subscribeProgressSpinner.stopAnimation(nil)
            return
        }
        
        let stripeToken: StripeToken
        do {
            try stripeToken = StripeToken(rawStripeData: token)
        } catch  {
            fatalError("Bad token error not implemented")
        }
        
        let country = countries.set.countryWithName(fromString: subscribeBillingCountry.titleOfSelectedItem)
        guard country != nil else {
            fatalError("Unknown country \(String(describing: subscribeBillingCountry.titleOfSelectedItem))")
        }
        let currency = currencies.set.currencyWithName(name: subscribeBillingCurrency.titleOfSelectedItem)
        guard currency != nil else {
            fatalError("Unknown currency \(String(describing: subscribeBillingCurrency.titleOfSelectedItem))")
        }
        let planSplit = subscribePlanSelection.titleOfSelectedItem?.split(separator: ":")[0]
        guard planSplit != nil else { fatalError("Unable to obtain plan name") }
        let planName = String(describing: planSplit!)
        let plan = plans.planSet.planWithName(planName)
        
        request = SubscriptionRequest(
            country: country!,
            currency: currency!,
            plan: plan,
            email: subscribeEmail.stringValue,
            passphrase: subscribePassphrase.stringValue,
            token: stripeToken
        )
        let identifier = NSStoryboardSegue.Identifier("welcomeProgressSegue")
        _ = performSegue(withIdentifier: identifier, sender: nil)
        return
    }

    @IBAction func billingCountryWasSelected(_ sender: NSPopUpButton) {
        populatePlanList()
    }

    @IBAction func billingCurrencyWasSelected(_ sender: NSPopUpButton) {
        populatePlanList()
    }

    @IBAction func selectedTermsAndConditions(_ sender: NSButton) {
        NSWorkspace.shared.open(urlTermsAndConditions)
        return
    }

    @IBAction func selectedPrivacyPolicy(_ sender: Any) {
        NSWorkspace.shared.open(urlPrivacyPolicy)
        return
    }

    @IBAction func selectedOfferDetails(_ sender: Any) {
        NSWorkspace.shared.open(urlOfferDetails)
        return
    }

    @IBAction func agreedToLegal(_ sender: Any) {
        updateSubscribeButtonState()
        return
    }
    
    @IBAction func executeSubscription(_ sender: TextButton) {
        if !formIsValid() { return }
        subscribeButton.isHidden = true
        subscribeProgressSpinner.startAnimation(nil)
        stripe?.requestToken(tokenCallback: processToken)
        return
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController as? WelcomeProgress {
            guard request != nil else { fatalError("Welcome segue occured with no request") }
            destination.installRequest(request!)
            return
        }
    }
    
}

extension WelcomeCreateAccount: WKScriptMessageHandler {

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard self.stripe != nil else { fatalError("Stripe view not available") }
        self.stripe!.processMessage(name: message.name, body: message.body)

    }
    
}

extension WelcomeCreateAccount: NSTextDelegate, NSControlTextEditingDelegate {
    
    override func controlTextDidBeginEditing(_ obj: Notification) {
        let field = obj.object as? SubscribeValidity
        field?.clearError()
    }
    
    override func controlTextDidEndEditing(_ obj: Notification) {
        let field = obj.object as? SubscribeValidity
        guard field != nil else { return }
        updateSubscribeButtonState()
        if field!.isValid() {
            field!.clearError()
        } else {
            field!.showError(message: field!.invalidMessage)
        }
    }
}
