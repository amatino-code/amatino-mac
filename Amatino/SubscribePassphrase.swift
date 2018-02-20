//
//  SubscribePassphrase.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class SubscribePassphrase: SubscribeTextField {

    let minimumLength = 8
    override var invalidMessage: String {
        get {
            return "Passphrase too short."
        }
    }

    override func isValid() -> Bool {
        if self.stringValue.characters.count < minimumLength {
            return false
        }
        return true
    }
    
}
