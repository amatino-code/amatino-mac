//
//  OpposingAccount.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableAccountView: TabularAccountView {
    
    private let row: LedgerRow

    init (
        for row: LedgerRow,
        frame frameRect: NSRect,
        selection: AccountSelection
    ) {
        
        self.row = row
        super.init(frame: frameRect, selection: selection)
        text.stringValue = row.opposingAccountName
        return
    }
    
    override func mouseEntered(with event: NSEvent) {
        text.isHidden = true
        selection.configureForDisplayInTable()
        selection.isEnabled = true
        addSubview(selection)
        constrainSelectionView()
        if let accountId = row.opposingAccountId {
            selection.selectAccount(withId: accountId)
        } // Else we have a split transaction
        super.mouseEntered(with: event)
    }
    

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
