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

    private static let defaultNoneTitle = "-"
    private let noneTitle: String
    
    override public var selectedNode: Node? {
        get {
            if let node = selectedItem?.representedObject as? Node {
                return node
            }
            return nil
        }
    }

    init(frame frameRect: NSRect, tree: Tree, noneTitle: String) {
        self.noneTitle = noneTitle
        super.init(frame: frameRect, tree: tree)
        self.insertItem(withTitle: noneTitle, at: 0)
        return
    }

    override convenience init (frame frameRect: NSRect, tree: Tree) {
        self.init(
            frame: frameRect,
            tree: tree,
            noneTitle: OptionalAccountSelection.defaultNoneTitle
        )
        return
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func selectNone() {
        selectItem(withTitle: noneTitle)
        return
    }

}
