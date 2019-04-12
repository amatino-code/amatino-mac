//
//  LedgerAccountInput.swift
//  Amatino
//
//  Created by Hugh Jeremy on 23/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerAccountInput: NSView {
    

    private let popUp = NSPopUpButton()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        popUp.frame = bounds
        popUp.pullsDown = false
        popUp.addItem(withTitle: "Assets")
        popUp.addItem(withTitle: "Liabilities")
        popUp.isBordered = false
        popUp.translatesAutoresizingMaskIntoConstraints = false
        addSubview(popUp)
        return
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
