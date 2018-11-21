//
//  AccountTypeSelection.swift
//  Amatino
//
//  Created by Hugh Jeremy on 1/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class AccountTypeSelection: NSPopUpButton {
    
    let types: [AccountType] = [.asset, .liability, .equity, .income, .expense]

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
