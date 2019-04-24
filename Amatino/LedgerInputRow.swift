//
//  LedgerInputRow.swift
//  Amatino
//
//  Created by Hugh Jeremy on 13/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerInputRow {
    
    public let date: LedgerDateInput
    public let description: LedgerDescriptionInput
    public let account: LedgerAccountInput
    public let debit: LedgerDebitInput
    public let credit: LedgerCreditInput
    public let preview: LedgerBalancePreview
    
    private let defaultRowHeight = CGFloat(24)
    private let defaultRowWidth = CGFloat(100)

    private var denominatingCustomUnit: Int? = nil
    private var denominatingGlobalUnit: Int? = nil
    
    private weak var attachedLedger: Ledger? = nil
    
    public init () {
        let rect = NSMakeRect(0, 0, defaultRowWidth, defaultRowHeight)
        date = LedgerDateInput(frame: rect)
        description = LedgerDescriptionInput(frame: rect)
        account = LedgerAccountInput(frame: rect)
        debit = LedgerDebitInput(frame: rect)
        credit = LedgerCreditInput(frame: rect)
        preview = LedgerBalancePreview(
            frame: rect,
            dateInput: date,
            debitInput: debit,
            creditInput: credit
        )

        debit.opposingSide = credit
        credit.opposingSide = debit

        return
    }
    
    public func act(for ledger: Ledger, offering accounts: AccountSelection) {
        denominatingCustomUnit = ledger.customUnitId
        denominatingGlobalUnit = ledger.globalUnitId
        attachedLedger = ledger
        account.offer(selection: accounts, followedBy: debit)
        return
    }
    
    public func offer(selection accounts: AccountSelection) {
        account.offer(selection: accounts, followedBy: debit)
        return
    }
    
    public func observeCompletion() {
        debit.whenDoneEditing(call: considerCompletion)
        credit.whenDoneEditing(call: considerCompletion)
        date.whenDoneEditing(call: considerCompletion)
        return
    }

    private func considerCompletion() {
        
        print("Consider completion")
        
        guard let ledger = attachedLedger else {
            DispatchQueue.main.async {
                let _ = GenericErrorController.init(
                    displaying: nil,
                    displayIn: NSApplication.shared.keyWindow!
                )
                return
            }
            return
        }
        
        preview.calculate(for: ledger)

        guard !debit.isFocused else { return }
        guard !credit.isFocused else { return }
        guard !description.isFocused else { return }
        guard !date.isFocused else { return }
        guard !account.isFocused else { return }
        guard account.selectedAccount != nil else { return }
        
        guard (debit.amount + credit.amount) != Decimal(0) else { return }
        
        guard let opposingAccount = account.selectedAccount else { return }
        


        let anchorSide: Side
        let opposingSide: Side
        let amount: Decimal
        
        if debit.amount == Decimal(0) {
            anchorSide = Side.credit
            opposingSide = Side.debit
            amount = credit.amount
        } else if credit.amount == Decimal(0) {
            anchorSide = Side.debit
            opposingSide = Side.credit
            amount = debit.amount
        } else {
            fatalError("Nonsensical amounts, cannot determine sides")
        }
        
        let entries = [
            Entry(
                side: anchorSide,
                accountId: ledger.account.accountId,
                amount: amount
            ),
            Entry(
                side: opposingSide,
                accountId: opposingAccount.accountId,
                amount: amount
            )
        ]

        let arguments: Transaction.CreateArguments
        
        if denominatingGlobalUnit == nil {
            guard let customUnit = denominatingCustomUnit else {
                fatalError("CustomUnit must be set if GlobalUnit is nil")
            }
            arguments = try! Transaction.CreateArguments(
                transactionTime: date.dateValue,
                description: description.stringValue,
                customUnitId: customUnit,
                entries: entries
            )
        } else {
            guard let globalUnit = denominatingGlobalUnit else {
                fatalError("GlobalUnit must be set if CustomUnit is nil")
            }
            arguments = try! Transaction.CreateArguments(
                transactionTime:
                date.dateValue,
                description: description.stringValue,
                globalUnitId: globalUnit,
                entries: entries
            )
        }
        
        Transaction.create(
            in: ledger.entity,
            arguments: arguments,
            then: creationCallback
        )

    }

    private func creationCallback(
        _ error: Error?,
        _ transaction: Transaction?
    ) {
        guard let transaction = transaction else {
            DispatchQueue.main.async {
                let _ = GenericErrorController(
                    displaying: error ?? AmatinoError(.inconsistentState),
                    displayIn: NSApplication.shared.keyWindow!
                )
                return
            }
            return
        }
        NotificationCenter.default.post(
            Notification(
                name: Notification.Name.TRANSACTION_DID_CREATE,
                object: transaction
            )
        )
    }
    
    public func clear() {
        return
    }

}
