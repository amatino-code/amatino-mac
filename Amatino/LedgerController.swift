//
//  LedgerController.swift
//  Amatino
//
//  Created by Hugh Jeremy on 11/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerController: NSViewController {
    
    private let ledger: Ledger
    
    init(displaying ledger: Ledger) {
        self.ledger = ledger
        super.init(nibName: nil, bundle: nil)
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//extension LedgerController: NSTableViewDataSource {
//
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return ledger.count
//    }
//
//    func tableView(
//        _ tableView: NSTableView,
//        objectValueFor tableColumn: NSTableColumn?,
//        row: Int
//    ) -> Any? {
//        return ledger[row]
//    }
//
//}
//
//extension LedgerController: NSTableViewDelegate {
//
//    func tableView(
//        _ tableView: NSTableView,
//        viewFor tableColumn: NSTableColumn?,
//        row: Int
//    ) -> NSView? {
//
//    }
//
//}
