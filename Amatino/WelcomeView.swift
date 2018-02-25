//
//  WelcomeView.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
import AmatinoApi

class WelcomeView: NSViewController {
    
    @IBOutlet weak var emailField: WelcomeEmail!
    @IBOutlet weak var passPhraseField: WelcomePassphrase!
    @IBOutlet weak var loginButton: WelcomeLogin!
    @IBOutlet weak var loginSpinner: NSProgressIndicator!
    
    private var login: Login? = nil
    
    override func viewWillAppear() {
        emailField.window?.makeFirstResponder(emailField)
        loginSpinner.isHidden = true
    }

    @IBAction func loginSelected(_ sender: Any) {
        if !emailField.isValid() || !passPhraseField.isValid() {
            return
        }
        
        loginSpinner.isHidden = false
        loginButton.isHidden = true

        do {
            try login = Login(email: emailField.stringValue, secret: passPhraseField.stringValue,
                              callback: readyCallback)
        } catch {
            fatalError("Uncaught Login error: \(error)")
        }

        return
    }
    
    private func readyCallback() {
        
        guard login != nil else { fatalError("Inconsistent internal state") }
        
        if login!.wasSuccessful() {
            let app = NSApplication.shared.delegate as! AppDelegate
            app.login = login
            app.showAccountingInterface(login!)
        } else {
            fatalError("Uncaught Login error: \(String(describing: login!.provideLoginError()))")
        }

        return
    }
    
}

extension WelcomeView: NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        if emailField.isValid() && passPhraseField.isValid() {
            loginButton.showHighlightState()
        } else {
            loginButton.showStandardState()
        }
        return
    }
}
