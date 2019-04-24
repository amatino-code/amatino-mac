//
//  OptionalAccountSelection.swift
//  Amatino
//
//  Created by Hugh Jeremy on 15/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class OptionalAccountSelection: AccountSelection {

    private let noneTitle: String

    init(frame frameRect: NSRect, tree: Tree, noneTitle: String) {
        self.noneTitle = noneTitle
        super.init(frame: frameRect, tree: tree, optional: true)
        //self.insertItem(withTitle: noneTitle, at: 0)
        //self.addItem(withObjectValue: "-")
        return
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func selectNone() {
        fatalError("Temp not implemented")
        //selectItem(withTitle: noneTitle)
        //return
    }

}
