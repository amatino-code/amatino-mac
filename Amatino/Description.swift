//
//  Description.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableDescriptionView: NSTextField {
    
    init(for row: LedgerRow, frame frameRect: NSRect) {
        super.init(frame: frameRect)
        stringValue = row.description
        isSelectable = true
        isBordered = false
        isBezeled = false
        drawsBackground = false
        isSelectable = true
        font = LedgerTableView.font
        return
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("Not implemented")
    }
    
}
