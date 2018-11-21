//
//  Description.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableDescriptionView: NSTableCellView {
    
    let cellText: NSTextField
    
    override init(frame frameRect: NSRect) {
        cellText = NSTextField(frame: frameRect)
        super.init(frame: frameRect)
        self.textField = cellText
        guard let row = objectValue as? LedgerRow else {
            textField?.stringValue = "Error"
            return
        }
        textField?.stringValue = row.description
        textField?.isSelectable = true
        return
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("Not implemented")
    }
    
}