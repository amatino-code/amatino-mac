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
    
    private let inputFont = NSFont.systemFont(ofSize: CGFloat(12))

    private var popUp: AccountSelection? = nil
    
    public var selectedAccount: AccountRepresentative {
        get {
            guard let popUp = popUp else { fatalError("Missing popUp") }
            return popUp.selectedNode
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        return
    }
    
    public func offer(selection: AccountSelection) {
        if let popUp = popUp{
            replaceSubview(popUp, with: selection)
        } else {
            addSubview(selection)
        }
        selection.preferredEdge = .minY
        selection.isBordered = false
        selection.font = inputFont
        let cell = LedgerAccountInputCell()
        selection.cell = cell
        cell.arrowPosition = .arrowAtCenter
        self.popUp = selection
        return
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
