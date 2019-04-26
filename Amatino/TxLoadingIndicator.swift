//
//  TxLoadingIndicator.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxLoadingIndicator: NSProgressIndicator {
    
    let defaultFrame = NSRect(x: 270, y: 115, width: 32, height: 32)
    
    init() {
        super.init(frame: defaultFrame)
        isIndeterminate = true
        controlSize = .regular
        return
    }
    
    required init?(coder decoder: NSCoder) { fatalError("Not implemented") }

}
