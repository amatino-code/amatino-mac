//
//  SubscribeEmail.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//
import Foundation
import Cocoa

class SubscribeEmail: SubscribeTextField {
    
    let validityPattern = "^[A-Z0-9._%+-]{1,64}@(?:[A-Z0-9-]{1,63}\\.){1,125}[A-Z]{2,63}$"
    override var invalidMessage: String {
        get {
            return "Email address appears invalid."
        }
    }
    
    override func isValid() -> Bool {

        let regex = try! NSRegularExpression(pattern: validityPattern, options: .caseInsensitive)
        let inputLength = self.stringValue.count
        
        if inputLength < 3 {
            return false
        }
        
        let matches = regex.matches(in: self.stringValue, options: [], range: NSMakeRange(0, inputLength))
        if matches.count > 0 {
            return true
        }
        
        return false
    }
    
}
