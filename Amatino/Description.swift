//
//  Description.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableDescriptionView: TabularDescriptionView {
    
    init(for row: LedgerRow, frame frameRect: NSRect) {
        super.init(description: row.description, frame: frameRect)
        return
    }
    
    required init?(coder decoder: NSCoder) { fatalError("Not implemented") }
    
}
