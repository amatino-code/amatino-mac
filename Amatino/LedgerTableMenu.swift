//
//  LedgerTableMenu.swift
//  Amatino
//
//  Created by Hugh Jeremy on 25/5/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableMenu: NSMenu {

    private static let newTxTitle = NSLocalizedString(
        "New Transaction",
        comment: "Presented in ledger contextual menu"
    )
    
    private weak var parentLedger: LedgerTableController?

    private let menuTitle = NSLocalizedString(
        "Ledger Menu",
        comment: "Presented on ledger context click"
    )

    private let editorAction = NSMenuItem(
        title: LedgerTableMenu.newTxTitle,
        action: #selector(openEditor),
        keyEquivalent: String(LedgerTableMenu.newTxTitle.first ?? "n")
    )
    
    init(of ledger: LedgerTableController) {
        super.init(title: menuTitle)
        addItem(editorAction)
        editorAction.isEnabled = true
        editorAction.target = self
        parentLedger = ledger
        return
    }
    
    @objc private func openEditor() {
        parentLedger?.presentAsSheet(parentLedger!.editor)
        print("Open Editor")
        return
    }
    
    required init(coder decoder: NSCoder) { fatalError("Not implemented") }
    
}
