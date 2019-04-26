//
//  TabularDescription.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class TabularDescriptionView: NSTextField {
    
    internal static let defaultFrame = NSRect(
        x: 0,
        y: 0,
        width: 100,
        height: 22
    )
    
    convenience init(_ description: String) {
        self.init(
            description: description,
            frame: TabularDescriptionView.defaultFrame
        )
        return
    }

    init(description: String, frame frameRect: NSRect) {
        super.init(frame: frameRect)
        stringValue = description
        isSelectable = true
        isBordered = false
        isBezeled = false
        drawsBackground = false
        isSelectable = true
        font = LedgerTableView.font
    }
    
    required init?(coder decoder: NSCoder) { fatalError("Not implemented") }
}
