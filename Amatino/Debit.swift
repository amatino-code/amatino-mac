//
//  Debit.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableDebitView: LedgerTableAmount {
    
    init(for row: LedgerRow, frame frameRect: NSRect) {
        super.init(frame: frameRect)
        stringValue = row.presentationDebit
        return
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        return
    }
}
