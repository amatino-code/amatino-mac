//
//  SubscribeTextField.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class SubscribeTextField: NSTextField, SubscribeValidity {
    
    var errorText: NSTextField? = nil
    
    var invalidMessage: String {
        get {
            return "Generic error message"
        }
    }
    
    func showError(message: String) {
        errorText?.stringValue = message
    }
    
    func clearError() {
        errorText?.stringValue = ""
    }
    
    func isValid() -> Bool {
        return true
    }
}
