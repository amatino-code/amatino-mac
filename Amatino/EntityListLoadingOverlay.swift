//
//  EntityListLoadingOverlay.swift
//  Amatino
//
//  Created by Hugh Jeremy on 30/10/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class EntityListLoadingOverlay: NSView {
    
    let indicator: NSProgressIndicator
    let backgroundColor = NSColor.controlBackgroundColor

    convenience init (overTable table: NSTableView) {
        self.init(frame: table.frame)
        return
    }

    override init(frame frameRect: NSRect) {
        indicator = NSProgressIndicator(frame: frameRect)
        indicator.style = .spinning
        indicator.isIndeterminate = true
        indicator.startAnimation(nil)
        super.init(frame: frameRect)
        self.addSubview(indicator)
        self.wantsLayer = true
        self.layer?.backgroundColor = backgroundColor.cgColor
        return
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
