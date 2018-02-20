//
//  WelcomeConfirmAccount.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class WelcomeConfirmAccount: NSViewController {

    private let successTextBase = "Success! We've sent an email to "
    private var customerEmail: String? = nil
    
    @IBOutlet weak var successText: NSTextField!
    
    
    override func viewDidLoad() {
        if customerEmail != nil {
            successText.stringValue = successTextBase + customerEmail!
        }
        return
    }
    
    func setCustomerEmail(email: String) {
        customerEmail = email
        return
    }
}
