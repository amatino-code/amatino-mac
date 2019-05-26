//
//  TabularAmountInput.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TabularAmountInput: NSTextField, NSTextDelegate {
    
    private let side: Side
    
    private let numberFormatter = NumberFormatter()
    private let adverseColor = NSColor.systemRed
    
    private var storedAmount: Decimal = 0
    
    private var doneEditingCallback: (() -> Void)? = nil
    
    public weak var opposingSide: TabularAmountInput?
    
    public private(set) var amount: Decimal {
        get {
            return storedAmount
        }
        set(newAmount) {
            storedAmount = max(0, newAmount)
            if storedAmount <= 0 { stringValue = ""; return }
            stringValue = numberFormatter.string(
                from: storedAmount as NSDecimalNumber
            )!
        }
    }
    
    convenience init(_ side: Side) {
        self.init(frame: NSRect(x: 0, y: 0, width: 100, height: 22), side: side)
        return
    }
    
    init(
        frame frameRect: NSRect,
        side: Side
        ) {
        self.side = side
        super.init(frame: frameRect)
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.currencySymbol = nil
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.localizesFormat = true
        formatter = numberFormatter
        placeholderString = numberFormatter.string(from: 0)!
        isBordered = false
        alignment = .right
        translatesAutoresizingMaskIntoConstraints = false
        drawsBackground = false
        font = LedgerTableView.monospacedFont
        return
    }
    
    override func textDidBeginEditing(_ notification: Notification) {
        textColor = NSColor.textColor
        return
    }
    
    override func textDidEndEditing(_ notification: Notification) {
        super.textDidEndEditing(notification)
        
        let parsedAmount = parseAmount()
        guard let newAmount = parsedAmount else { warnOfBadNumber(); return }
        guard let opposition = opposingSide else { return }
        let opposingAmount = opposition.add(
            amount: newAmount,
            side: self.side
        )
        amount = newAmount - opposingAmount
        doneEditingCallback?()
        return
    }
    
    private func parseAmount() -> Decimal? {
        if stringValue.isEmpty { return Decimal(0) }
        let parsed = numberFormatter.number(from: stringValue)?.decimalValue
        return parsed
    }
    
    private func warnOfBadNumber () {
        amount = 0
        shake()
        textColor = adverseColor
        return
    }
    
    public func whenDoneEditing(call callback: @escaping () -> Void) {
        doneEditingCallback = callback
        return
    }
    
    public func add(amount: Decimal, side: Side) -> Decimal {
        if side == self.side {
            self.amount += amount
        } else {
            self.amount -= amount
        }
        return self.amount
    }
    
    required init?(coder decoder: NSCoder) { fatalError("Not implemented") }
    
}

