//
//  Date.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableDateView: NSTextField {
    
    let dateFormatter = DateFormatter()

    init(for row: LedgerRow, frame frameRect: NSRect) {
        super.init(frame: frameRect)
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .short
        let dateString = dateFormatter.string(from: row.transactionTime)
        stringValue = dateString
        isBezeled = false
        isBordered = false
        drawsBackground = false
        isSelectable = true
        font = LedgerTableView.monospacedFont
        return
        
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        return
    }
}
