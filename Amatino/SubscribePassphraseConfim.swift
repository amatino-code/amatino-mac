//
//  SubscribePassphraseConfim.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class SubscribePassphraseConfirm: SubscribeTextField {
    
    override var invalidMessage: String {
        get {
            return "Passwords do not match."
        }
    }

    var passphrase: SubscribePassphrase? = nil

    override func isValid() -> Bool {
        guard passphrase != nil else { fatalError("Passphrase not set") }
        if passphrase!.stringValue == self.stringValue {
            return true
        }
        return false
    }
}
