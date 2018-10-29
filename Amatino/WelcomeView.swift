//
//  WelcomeView.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

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

        login = Login(
            email: emailField.stringValue,
            secret: passPhraseField.stringValue,
            callback: readyCallback
        )

        return
    }
    
    private func readyCallback(error: Error?) {

        guard let login = login else {
            fatalError("Inconsistent internal state")
        }

        if error != nil {
            fatalError("Uncaught Login error")
        }

        let app = NSApplication.shared.delegate as! AppDelegate
        app.login = login
        
        DispatchQueue.main.async {
            app.showEntityListInterface(login: login)
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
