//
//  AccountSelection.swift
//  Amatino
//
//  Created by Hugh Jeremy on 15/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class AccountSelection: AMPopUpButton {
    
    private let tree: Tree
    private let doesPullDown = false

    public var selectedNode: Node! {
        get {
            return (selectedItem!.representedObject as! Node)
        }
    }

    init(frame frameRect: NSRect, tree: Tree) {
        self.tree = tree
        super.init(frame: frameRect, pullsDown: doesPullDown)
        let nodes = tree.flatAccounts
        if nodes.count < 1 {
            self.isEnabled = false
            self.addItem(withTitle: "-")
            return
        }
        let _ = nodes.map { self.addItem(withTitle: self.titleFor($0)) }
        let _ = nodes.map {
            item(withTitle: titleFor($0))?.representedObject = $0
        }
        return
    }

    private func titleFor(_ node: Node) -> String {
        let whitespace = String(repeating: "  ", count: node.depth - 1)
        return whitespace + node.name
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
