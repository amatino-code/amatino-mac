//
//  TxEditorImbalanceLabel.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEditorImbalanceLabel: NSTextField {
    
    let content = NSLocalizedString(
        "Imbalance:",
        comment: "Warning of imbalance between debits & credits"
    )
    
    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: 100, height: 22))
        isEditable = false
        isSelectable = false
        stringValue = content
        alignment = .right
        font = TransactionEditor.font
        return
    }
    
    required init?(coder: NSCoder) { fatalError("Not implemented") }

}
