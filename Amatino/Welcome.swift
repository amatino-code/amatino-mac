//
//  Welcome.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class Welcome: NSWindow {
    
    let welcomeBackgroundColor = NSColor(white: 1.0, alpha: 1.0)
    
    override init(
        contentRect: NSRect,
        styleMask style: NSWindow.StyleMask,
        backing backingStoreType: NSWindow.BackingStoreType,
        defer flag: Bool
    ) {
        super.init(
            contentRect: contentRect,
            styleMask: style,
            backing: backingStoreType,
            defer: flag
        )
        self.backgroundColor = welcomeBackgroundColor
        self.isMovableByWindowBackground = true
    }
    
    override var canBecomeKey: Bool {
        return true
    }

}

