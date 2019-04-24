//
//  Amount.swift
//  Amatino
//
//  Created by Hugh Jeremy on 24/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableAmount: NSTextField {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        isSelectable = true
        isBezeled = false
        drawsBackground = false
        isBordered = false
        font = LedgerTableView.monospacedFont
        alignment = .right
        return
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        return
    }
}
