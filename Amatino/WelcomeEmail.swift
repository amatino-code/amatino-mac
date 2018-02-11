//
//  WelcomeEmail.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class WelcomeEmail: NSTextField {
    
    let validityThreshold = 3
    
    func isValid() -> Bool {

        let text = self.stringValue
        if text.characters.count > validityThreshold {
            return true
        }
        
        return false
    }
    
}
