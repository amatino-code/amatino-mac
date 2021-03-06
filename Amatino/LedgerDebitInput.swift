//
//  LedgerDebitInput.swift
//  Amatino
//
//  Created by Hugh Jeremy on 23/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerDebitInput: TabularAmountInput {
    
    init(frame frameRect: NSRect) {
        super.init(frame: frameRect, side: .debit)
        return
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func rightMouseDown(with event: NSEvent) {
        print("Right mouse down!")
        super.rightMouseDown(with: event)
    }
    
}
