//
//  Debit.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableDebitView: NSTableCellView {
    
    let cellText: NSTextField
    
    init(for row: LedgerRow, frame frameRect: NSRect) {
        cellText = NSTextField(frame: frameRect)
        super.init(frame: frameRect)
        textField = cellText
        textField?.stringValue = row.presentationDebit
        textField?.isSelectable = true
        return
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("Not implemented")
    }
    
}
