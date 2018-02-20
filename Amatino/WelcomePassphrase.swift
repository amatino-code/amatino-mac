//
//  WelcomePassphrase.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//
import Foundation
import Cocoa

class WelcomePassphrase: NSTextField {
    
    let validityThreshold = 6
    
    func isValid() -> Bool {
        
        self.focusRingType = NSFocusRingType.none
        let text = self.stringValue
        if text.characters.count > validityThreshold {
            return true
        }
        
        return false
    }
    
    func viewDidLoad() {
        self.focusRingType = NSFocusRingType.none
    }
}

