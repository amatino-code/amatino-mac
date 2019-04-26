//
//  TabularCreditInput.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation

class TabularCreditInput: TabularAmountInput {
    
    init() {
        super.init(
            frame: NSRect(x: 0, y: 0, width: 100, height: 22),
            side: .credit
        )
    }
    
    required init?(coder decoder: NSCoder) { fatalError("Not implemented") }
    
}
