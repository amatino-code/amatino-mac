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
    
    let ledgerView: LedgerView
    
    init() {
        ledgerView = LedgerView()
        super.init(nibName: nil, bundle: nil)
        return
    }
    
    override func loadView() {
        self.view = ledgerView
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func presentLedger(
        forAccount account: AccountRepresentative,
        in entity: Entity,
        ordered order: LedgerOrder
    ) {
        
        ledgerView.showLoading()
        
        Ledger.retrieve(
            for: account,
            in: entity,
            inOrder: order,
            then: self.ledgerReadyCallback
        )
        
    }
    
    private func ledgerReadyCallback(error: Error?, ledger: Ledger?) {
        DispatchQueue.main.async {
            guard let ledger = ledger else {
                let _ = GenericErrorController(
                    displaying: error ?? AmatinoAppError(.internalFailure),
                    presentedBy: self
                )
                return
            }
            
            self.ledgerView.present(ledger)
        }
        return
    }
    
    public func showIdle() { ledgerView.showIdle() }

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
