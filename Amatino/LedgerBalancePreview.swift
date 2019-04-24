//
//  LedgerBalancePreview.swift
//  Amatino
//
//  Created by Hugh Jeremy on 23/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerBalancePreview: NSTextField {
    
    private let date: LedgerDateInput
    private let debit: LedgerDebitInput
    private let credit: LedgerCreditInput
    
    private let numberFormatter = NumberFormatter()
    
    init(
        frame frameRect: NSRect,
        dateInput date: LedgerDateInput,
        debitInput debit: LedgerDebitInput,
        creditInput credit: LedgerCreditInput
    ) {
        self.debit = debit
        self.credit = credit
        self.date = date
        super.init(frame: frameRect)
        isEditable = false
        drawsBackground = false
        isBezeled = false
        isBordered = false
        isSelectable = true
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.currencySymbol = nil
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.localizesFormat = true
        formatter = numberFormatter
        font = LedgerTableView.monospacedFont
        alignment = .right
        return
    }
    
    public func calculate(for ledger: Ledger) {
        
        // Get the last row whose date is less than the input date, and
        // sum the balance
        
        let previousBalance: Decimal
        switch ledger.order {
        case.oldestFirst:
            var candidate: LedgerRow? = nil
            for row in ledger {
                if row.transactionTime <= date.dateValue {
                    candidate = row
                    continue
                } else { break }
            }
            previousBalance = candidate?.balance ?? Decimal(0)
        case.youngestFirst:
            var candidate: LedgerRow? = nil
            for row in ledger.reversed() {
                if row.transactionTime <= date.dateValue {
                    candidate = row
                    continue
                } else { break }
            }
            previousBalance = candidate?.balance ?? Decimal(0)
        }
        
        let amType = ledger.account.type

        let previewBalance: Decimal
        if amType == .asset || amType == .expense {
            previewBalance = previousBalance + debit.amount - credit.amount
        } else {
            previewBalance = previousBalance - debit.amount + credit.amount
        }
        
        guard let rawStringValue = numberFormatter.string(
            for: abs(previewBalance)
        ) else {
            fatalError("Unable to format Decimal \(previewBalance)")
        }
        if previewBalance == 0 { stringValue = ""; return }
        if previewBalance >= 0 { stringValue = rawStringValue; return }
        stringValue = "(" + rawStringValue + ")"
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
