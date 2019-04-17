//
//  LedgerTableView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 22/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableView: NSTableView {
    
    private var ledger: Ledger?
    private var accountSelection: AccountSelection?
    
    private let dateColId =  NSUserInterfaceItemIdentifier("dataCol")
    private let descrColId =  NSUserInterfaceItemIdentifier("descColId")
    private let oppoColId = NSUserInterfaceItemIdentifier("oppoColId")
    private let drColId = NSUserInterfaceItemIdentifier("drColId")
    private let crColId = NSUserInterfaceItemIdentifier("crColId")
    private let balColId = NSUserInterfaceItemIdentifier("balColId")

    private let dateColumn: NSTableColumn
    private let descriptionColumn: NSTableColumn
    private let oppositionColumn: NSTableColumn
    private let debitColumn: NSTableColumn
    private let creditColumn: NSTableColumn
    private let balanceColumn: NSTableColumn
    
    private let dateName = NSLocalizedString("Date", comment: "")
    private let descriptionName = NSLocalizedString("Description", comment: "")
    private let oppoName = NSLocalizedString("Opposing Account", comment: "")
    private let drName = NSLocalizedString("Debit", comment: "")
    private let crName = NSLocalizedString("Credit", comment: "")
    private let balanceName = NSLocalizedString("Balance", comment: "")
    
    private let inputRow: LedgerInputRow
    
    private let defaultRowHeight = CGFloat(24)
    
    override init(frame frameRect: NSRect) {
        
        dateColumn = NSTableColumn(identifier: dateColId)
        descriptionColumn = NSTableColumn(identifier: descrColId)
        oppositionColumn = NSTableColumn(identifier: oppoColId)
        debitColumn = NSTableColumn(identifier: drColId)
        creditColumn = NSTableColumn(identifier: crColId)
        balanceColumn = NSTableColumn(identifier: balColId)
        
        dateColumn.headerCell.stringValue = dateName
        descriptionColumn.headerCell.stringValue = descriptionName
        oppositionColumn.headerCell.stringValue = oppoName
        debitColumn.headerCell.stringValue = drName
        creditColumn.headerCell.stringValue = crName
        balanceColumn.headerCell.stringValue = balanceName

        dateColumn.width = CGFloat(70)
        descriptionColumn.width = CGFloat(200)
        oppositionColumn.width = CGFloat(100)
        debitColumn.width = CGFloat(60)
        creditColumn.width = CGFloat(60)
        balanceColumn.width = CGFloat(60)
        
        inputRow = LedgerInputRow()
        inputRow.observeCompletion()
    
        super.init(frame: frameRect)
        
        let columns = [
            dateColumn,
            descriptionColumn,
            oppositionColumn,
            debitColumn,
            creditColumn,
            balanceColumn
        ]
        
        let _ = columns.map { $0.tableView = self }
        let _ = columns.map {
            $0.resizingMask = [.autoresizingMask, .userResizingMask]
        }
        let _ = columns.map { self.addTableColumn($0) }
        
        delegate = self
        dataSource = self
        
        usesAlternatingRowBackgroundColors = true
        columnAutoresizingStyle = .uniformColumnAutoresizingStyle

        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func load(_ ledger: Ledger, withAccountsFrom tree: Tree) {
        self.ledger = ledger
        let selection = AccountSelection(
            frame: NSMakeRect(0, 0, CGFloat(100), defaultRowHeight),
            tree: tree
        )
        self.inputRow.act(for: ledger, offering: selection)
        self.accountSelection = selection
        self.reloadData()
        self.sizeToFit()
        return
    }
    
    public func refresh(_ ledger: Ledger) {
        self.ledger = ledger
        self.reloadData()
        return
    }
    
    override func validateProposedFirstResponder(
        _ responder: NSResponder,
        for event: NSEvent?
    ) -> Bool {
        return true
    }

}

extension LedgerTableView: NSTableViewDelegate {
    
    func tableView(
        _ tableView: NSTableView,
        viewFor tableColumn: NSTableColumn?,
        row: Int
    ) -> NSView? {
        
        guard let column = tableColumn else {
            return nil
        }
        
        guard let ledger = ledger else {
            return nil
        }
        
        if row >= ledger.count {
            return inputCell(for: column)
        }
        
        let ledgerRow = ledger[row]
        let cellFrame = NSMakeRect(0, 0, column.width, rowHeight)
        
        switch column.identifier {
        case dateColId:
            return LedgerTableDateView(for: ledgerRow, frame: cellFrame)
        case descrColId:
            return LedgerTableDescriptionView(for: ledgerRow, frame: cellFrame)
        case oppoColId:
            return LedgerTableAccountView(for: ledgerRow, frame: cellFrame)
        case drColId:
            return LedgerTableDebitView(for: ledgerRow, frame: cellFrame)
        case crColId:
            return LedgerTableCreditView(for: ledgerRow, frame: cellFrame)
        case balColId:
            return LedgerTableBalanceView(for: ledgerRow, frame: cellFrame)
        default:
            fatalError("Unknown table column")
        }
    }
    
    private func inputCell(for column: NSTableColumn) -> NSView {
        switch column.identifier {
        case dateColId:
            return inputRow.date
        case descrColId:
            return inputRow.description
        case oppoColId:
            return inputRow.account
        case drColId:
            return inputRow.debit
        case crColId:
            return inputRow.credit
        case balColId:
            return inputRow.preview
        default:
            fatalError("Unknown table column")
        }
    }
    
}

extension LedgerTableView: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (ledger?.count ?? 0) + 1
    }

    func tableView(
        _ tableView: NSTableView,
        objectValueFor tableColumn: NSTableColumn?,
        row: Int
    ) -> Any? {
        guard let ledger = ledger else {
            return nil
        }
        if row >= ledger.count {
            return nil // The input row
        }
        return ledger[row]
    }

}
