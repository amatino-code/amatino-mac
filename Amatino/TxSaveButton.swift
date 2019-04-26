//
//  TxSaveButton.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEditorSaveButton: NSButton {
    
    let defaultFrame = NSRect(x: 489, y: 9, width: 70, height: 32)
    
    init() {
        super.init(frame: defaultFrame)
    }
    
    override required init?(coder: NSCoder) { fatalError("Not implemented") }
    
}
