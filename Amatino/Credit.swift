//
//  Credit.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableCreditView: NSTableCellView {
    
    let cellText = NSTextField()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        cellText.frame = frameRect
        textField = cellText
        guard let row = objectValue as? LedgerRow else {
            textField?.stringValue = "Error"
            return
        }
        textField?.stringValue = row.presentationCredit
        textField?.isSelectable = true
        return
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        return
    }
    
}

