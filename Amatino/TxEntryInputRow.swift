//
//  TxEntryInputRow.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEntryInputRow {
    
    private let defaultFrame = NSRect(x: 0, y: 0, width: 24, height: 100)
    
    public let description: LedgerDescriptionInput
    public let account: LedgerAccountInput
    public let debit: LedgerDebitInput
    public let credit: LedgerCreditInput
    
    public init() {

        description = LedgerDescriptionInput(frame: defaultFrame)
        account = LedgerAccountInput(frame: defaultFrame)
        debit = LedgerDebitInput(frame: defaultFrame)
        credit = LedgerCreditInput(frame: defaultFrame)
        
        debit.opposingSide = credit
        credit.opposingSide = debit
        
        return
    }
    
    public func offer(_ accounts: AccountSelection) {
        account.offer(selection: accounts, followedBy: debit)
        return
    }

}
