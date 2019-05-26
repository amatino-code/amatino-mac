//
//  LedgerTableController.swift
//  Amatino
//
//  Created by Hugh Jeremy on 25/5/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class LedgerTableController: NSViewController {
    
    public let editor =  TransactionEditorController()
    
    private let ledgerTableView: LedgerTableView
    private let defaultFrame = NSMakeRect(0, 0, 761, 475)
    
    private var ledger: Ledger?
    
    init() {
        ledgerTableView = LedgerTableView(frame: defaultFrame)
        super.init(nibName: nil, bundle: nil)
        ledgerTableView.menu = LedgerTableMenu(of: self)
        return
    }

    override func loadView() {
        self.view = ledgerTableView
        return
    }
    
    public func load(_ ledger: Ledger, withAccountsFrom tree: Tree) {
        self.ledger = ledger
        ledgerTableView.load(ledger, withAccountsFrom: tree)
        return
    }

    required init?(coder: NSCoder) { fatalError("not implemented") }
    
}
