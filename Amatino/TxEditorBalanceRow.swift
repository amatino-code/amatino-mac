//
//  TxEditorBalanceRow.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

struct TxEditorImbalance {
    let side: Side
    let magnitude: Decimal
    init(_ side: Side, _ magnitude: Decimal) {
        self.side = side
        self.magnitude = magnitude
    }
}

class TxEditorBalanceRow {
    
    private let plugButton = TxEditorPlugButton()
    private let imbalanceLabel = TxEditorImbalanceLabel()
    private let debitImbalance = TxEditorImbalanceDisplay()
    private let creditImbalance = TxEditorImbalanceDisplay()
    
    init() {
        
    }
    
    public func computeFor(entries: Array<Entry>) -> TxEditorImbalance? {
        var creditBalance = Decimal(0)
        var debitBalance = Decimal(0)
        for entry in entries {
            if entry.side == .credit { creditBalance += entry.amount }
            if entry.side == .debit { debitBalance += entry.amount }
        }
        if creditBalance == debitBalance { hide(); return nil }
        if creditBalance > debitBalance {
            return TxEditorImbalance(.debit, creditBalance - debitBalance)
        } else {
            return TxEditorImbalance(.credit, debitBalance - creditBalance)
        }
    }
    
    private func hide() {
        plugButton.isHidden = true
        imbalanceLabel.isHidden = true
        debitImbalance.stringValue = ""
        creditImbalance.stringValue = ""
    }
    
    private func show(_ magnitude: Decimal, _ side: Side) {
        
    }
    
}
