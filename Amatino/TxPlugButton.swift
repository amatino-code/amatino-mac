//
//  TxPlugButton.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEditorPlugButton: NSButton {
    
    private let plugTitle = NSLocalizedString(
        "Plug",
        comment: "Button to plug ('fix') a gap between debit & credit balances"
    )
    
    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: 100, height: 26))
        self.title = plugTitle
        return
    }

    required init?(coder: NSCoder) { fatalError("Not implemented") }
    
}
