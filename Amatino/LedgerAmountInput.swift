//
//  LedgerAmountInput.swift
//  Amatino
//
//  Created by Hugh Jeremy on 28/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerAmountInput: NSTextField {
    
    private let side: Side
    private let text = NSTextField()
    private let numberFormatter = NumberFormatter()
    private let adverseColor = NSColor.systemRed
    private var storedAmount: Decimal = 0
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
    public weak var opposingSide: LedgerAmountInput?
    
    init(frame frameRect: NSRect, side: Side) {
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
        return
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textDidBeginEditing(_ notification: Notification) {
        textColor = NSColor.textColor
        return
    }
    
    override func textDidEndEditing(_ notification: Notification) {
        super.textDidEndEditing(notification)
        if stringValue.isEmpty { amount = 0; return }
        let parsedAmount = numberFormatter.number(from: stringValue)
        guard let parsed = parsedAmount else { warnOfBadNumber(); return }
        guard let opposition = opposingSide else { return }
        let opposingAmount = opposition.add(
            amount: parsed.decimalValue,
            side: self.side
        )
        amount = parsed.decimalValue - opposingAmount
        return
    }
    
    private func warnOfBadNumber () {
        amount = 0
        shake()
        textColor = adverseColor
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
}
