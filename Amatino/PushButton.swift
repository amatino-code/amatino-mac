//
//  PushButton.swift
//  Amatino
//
//  Created by Hugh Jeremy on 17/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class PushButton: AMButton {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        isBordered = true
        bezelStyle = .rounded
        setButtonType(.momentaryPushIn)
        return
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        return
    }
}
