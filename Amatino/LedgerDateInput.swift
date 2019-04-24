//
//  LedgerDateInput.swift
//  Amatino
//
//  Created by Hugh Jeremy on 23/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerDateInput: NSTextField, NSTextFieldDelegate {
    
    public private(set) var dateValue = Date()
    
    private let dateFormatter = DateFormatter()
    private let adverseColor = NSColor.systemRed
    
    private var doneEditingCallback: (() -> Void)? = nil

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.isLenient = true
        placeholderString = dateFormatter.string(from: dateValue)
        isBordered = false
        isBezeled = false
        delegate = self
        drawsBackground = false
        font = LedgerTableView.monospacedFont
        return
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(with event: NSEvent) {
        if stringValue.isEmpty {
            stringValue = dateFormatter.string(from: dateValue)
            if let textEditor = currentEditor() {
                textEditor.selectAll(self)
                return
            }
        }
        super.mouseDown(with: event)
        return
    }
    
    public func whenDoneEditing(call callback: @escaping () -> Void) {
        doneEditingCallback = callback
        return
    }
    
    override func textDidBeginEditing(_ notification: Notification) {
        textColor = NSColor.textColor
        return
    }
    
    override func textDidEndEditing(_ notification: Notification) {
        super.textDidEndEditing(notification)
        if stringValue.isEmpty {
            dateValue = Date()
            stringValue = dateFormatter.string(from: dateValue)
            doneEditingCallback?()
            return
        }
        let parsedDate = dateFormatter.date(from: stringValue)
        guard let date = parsedDate else { warnOfBadDate(); return }
        dateValue = date
        doneEditingCallback?()
        return
    }
    
    private func warnOfBadDate() {
        shake()
        textColor = adverseColor
        return
    }
    
    
}
