//
//  TxCancelButton.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEditorCancelButton: NSButton {
    
    let defaultFrame = NSRect(x: 403, y: 9, width: 82, height: 32)
    
    init() {
        super.init(frame: defaultFrame)
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
