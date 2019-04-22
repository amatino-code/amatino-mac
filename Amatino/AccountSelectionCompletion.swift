//
//  AccountSelectionCompletion.swift
//  Amatino
//
//  Created by Hugh Jeremy on 21/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class AccountSelectionCompletion: NSView, NSTableViewDataSource {
    
    private var candidates = Array<AccountSelection.Item>()
    private let table = NSTableView()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


