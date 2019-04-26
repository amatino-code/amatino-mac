//
//  TxDescriptionField.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxDescriptionField: NSTextField {
    
    let defaultFrame = NSRect(x: 231, y: 218, width: 321, height: 22)

    init() {
        super.init(frame: defaultFrame)
    }

    required init?(coder: NSCoder) { fatalError("Not implemented") }

}
