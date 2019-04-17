//
//  NSTextField.swift
//  Amatino
//
//  Created by Hugh Jeremy on 13/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

extension NSTextField {
    
    public var isFocused: Bool {
        get {
            if self.window?.firstResponder == self.currentEditor() {
                return true
            }
            return false
        }
    }
    
}
