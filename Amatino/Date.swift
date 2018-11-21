//
//  Date.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableDateView: NSTableCellView {
    
    let formatter = DateFormatter()
    let cellText = NSTextField()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.textField = cellText
        guard let row = objectValue as? LedgerRow else {
            textField?.stringValue = "Error"
            return
        }
        formatter.locale = Locale.current
        let dateString = formatter.string(from: row.transactionTime)
        textField?.stringValue = dateString
        textField?.isSelectable = true
        return
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        return
    }
}
