//
//  WelcomePassphrase.swift
//  Amatino
//
//  Created by Hugh Jeremy on 11/2/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
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

