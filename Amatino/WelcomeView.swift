//
//  WelcomeView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 11/2/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class WelcomeView: NSViewController {
    
    @IBOutlet weak var emailField: WelcomeEmail!
    @IBOutlet weak var passPhraseField: WelcomePassphrase!
    @IBOutlet weak var loginButton: WelcomeLogin!
    
    override func viewDidLoad() {
        emailField.window?.makeFirstResponder(emailField)
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
