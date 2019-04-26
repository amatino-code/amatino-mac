//
//  TxDatePicker.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEditorDatePicker: NSDatePicker {
    
    let defaultFrame = NSRect(x: 20, y: 217, width: 217, height: 20)
    
    init() {
        super.init(frame: defaultFrame)
    }

    required init?(coder: NSCoder) { fatalError("Not implemented") }

}
