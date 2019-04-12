//
//  OpposingAccount.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableAccountView: NSView {
    
    private let text = NSTextField()
    private let popUp = NSPopUpButton()
    private var trackingArea: NSTrackingArea?
    
    init (for row: LedgerRow, frame frameRect: NSRect) {
        super.init(frame: frameRect)
        text.frame = bounds
        text.stringValue = row.opposingAccountName
        text.isBordered = false
        addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        popUp.frame = bounds
        popUp.pullsDown = false
        popUp.addItem(withTitle: "Assets")
        popUp.addItem(withTitle: "Liabilities")
        popUp.isBordered = false
        popUp.translatesAutoresizingMaskIntoConstraints = false
        return
    }
    
    override func mouseEntered(with event: NSEvent) {
        print("Mouse entered!")
        text.isHidden = true
        addSubview(popUp)
        super.mouseEntered(with: event)
    }
    
    override func mouseExited(with event: NSEvent) {
        print("Mouse exited!")
        text.isHidden = false
        popUp.removeFromSuperview()
        super.mouseExited(with: event)
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if let existingArea = trackingArea {
            removeTrackingArea(existingArea)
            trackingArea = nil
            return
        }
        let newArea = NSTrackingArea(
            rect: self.bounds,
            options: [.mouseEnteredAndExited, .activeInKeyWindow],
            owner: self,
            userInfo: nil
        )
        trackingArea = newArea
        addTrackingArea(newArea)
        return
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
