//
//  Label.swift
//  Amatino
//
//  Created by Hugh Jeremy on 9/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class Label: NSTextField {
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        isBezeled = false
        drawsBackground = false
        isEditable = false
        isSelectable = false
        font = NSFont.systemFont(ofSize: NSFont.systemFontSize)
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
