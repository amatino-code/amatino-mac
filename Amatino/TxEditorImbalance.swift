//
//  TxEditorImbalance.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEditorImbalanceDisplay: NSTextField {
    
    private let numberFormatter = NumberFormatter()
    
    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: 100, height: 22))
        isEditable = false
        isSelectable = true
        font = TransactionEditor.monospacedFont
        isBordered = false
        alignment = .right
        drawsBackground = false
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.currencySymbol = nil
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.localizesFormat = true
        formatter = numberFormatter
        stringValue = ""
        return
    }
    
    public func displayImbalance(_ imbalance: Decimal) {
        if imbalance == Decimal(0) { stringValue = ""; return }
        guard let string = numberFormatter.string(
            from: NSDecimalNumber(decimal: imbalance)
        ) else { fatalError("Could not display \(imbalance)") }
        stringValue = string
        return
    }
    
    public func clear() { stringValue = ""; return }
    
    required init?(coder: NSCoder) { fatalError("Not implemented") }
    
}
