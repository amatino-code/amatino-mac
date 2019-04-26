//
//  TxEntryTable.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEntryTable: NSTableView, NSTableViewDataSource, NSTableViewDelegate {
    
    private let defaultFrame = NSRect(x: 20, y: 49, width: 532, height: 154)
    
    private var presentedTransaction: Transaction? = nil
    private var accountSelection: AccountSelection? = nil
    private var entries = Array<Entry>()
    
    private let inputRow = TxEntryInputRow()
    
    private let descrColId =  NSUserInterfaceItemIdentifier("descColId")
    private let oppoColId = NSUserInterfaceItemIdentifier("oppoColId")
    private let drColId = NSUserInterfaceItemIdentifier("drColId")
    private let crColId = NSUserInterfaceItemIdentifier("crColId")
    
    private let descriptionColumn: NSTableColumn
    private let oppositionColumn: NSTableColumn
    private let debitColumn: NSTableColumn
    private let creditColumn: NSTableColumn
    
    private let descriptionName = NSLocalizedString("Description", comment: "")
    private let oppoName = NSLocalizedString("Opposing Account", comment: "")
    private let drName = NSLocalizedString("Debit", comment: "")
    private let crName = NSLocalizedString("Credit", comment: "")
    
    private var inputRowIndex: Int { get { return entries.count + 1 } }
    private var balanceRowIndex: Int { get { return inputRowIndex + 1 } }
    
    init() {
        
        descriptionColumn = NSTableColumn(identifier: descrColId)
        oppositionColumn = NSTableColumn(identifier: oppoColId)
        debitColumn = NSTableColumn(identifier: drColId)
        creditColumn = NSTableColumn(identifier: crColId)
        
        super.init(frame: defaultFrame)
        
        let columns = [
            descriptionColumn,
            oppositionColumn,
            debitColumn,
            creditColumn
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
    
    public func present(_ transaction: Transaction) {
        presentedTransaction = transaction
        entries = transaction.entries
        reloadData()
        return
    }
    
    required init?(coder: NSCoder) { fatalError("Not implemented") }
    
    func tableView(
        _ tableView: NSTableView,
        viewFor tableColumn: NSTableColumn?,
        row: Int
    ) -> NSView? {

        guard let column = tableColumn else { return nil }
        if row == inputRowIndex { return inputCellFor(column) }
        if row == balanceRowIndex { return balanceCellFor(column) }
        return entryCellFor(row: row, column: column)

    }
    
    func inputCellFor(_ column: NSTableColumn) -> NSView {
        switch column.identifier {
        case descrColId:
            return inputRow.description
        case oppoColId:
            return inputRow.account
        case drColId:
            return inputRow.debit
        case crColId:
            return inputRow.credit
        default:
            fatalError("Unrecognised column \(column.identifier)")
        }
    }
    
    func balanceCellFor(_ column: NSTableColumn) -> NSView {
        fatalError("Not implemented")
        // return a balance row cell
    }
    
    func entryCellFor(row: Int, column: NSTableColumn) -> NSView {
        guard row < entries.count else { fatalError("\(row) exceeds bounds") }
        guard let selection = accountSelection else {
            fatalError("Account selection missing")
        }
        let entry = entries[row]
        switch column.identifier {
        case descrColId:
            return TabularDescriptionView(entry.description)
        case oppoColId:
            return TabularAccountView(selection)
        case drColId:
            return TabularDebitInput()
        case crColId:
            return TabularCreditInput()
        default:
            fatalError("Unexpected table column: \(column.identifier)")
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return entries.count + 2 // Input row & balance row
    }

}
