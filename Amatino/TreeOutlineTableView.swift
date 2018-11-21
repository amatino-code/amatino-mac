//
//  TreeOutlineTableView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 21/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class TreeOutlineTableView: NSOutlineView {
    
    private let accountColumnId =  NSUserInterfaceItemIdentifier(
        "accountColumn"
    )
    private let balanceColumnId =  NSUserInterfaceItemIdentifier(
        "balanceColumn"
    )
    private let accountCellId = NSUserInterfaceItemIdentifier("accountCell")
    private let balanceCellId = NSUserInterfaceItemIdentifier("balanceCell")
    
    var tree: Tree?
    
    init(frame frameRect: NSRect, outlining tree: Tree) {
        self.tree = tree
        super.init(frame: frameRect)
        let outlineColumn = NSTableColumn(identifier: accountColumnId)
        let balanceColumn = NSTableColumn(identifier: balanceColumnId)
        addTableColumn(outlineColumn)
        addTableColumn(balanceColumn)
        outlineTableColumn = outlineColumn
        delegate = self
        dataSource = self
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func load(_ tree: Tree) {
        self.tree = tree
        reloadData()
        return
    }
    
}

extension TreeOutlineTableView: NSOutlineViewDelegate {
    
    func outlineView(
        _ outlineView: NSOutlineView,
        viewFor tableColumn: NSTableColumn?,
        item: Any
        ) -> NSView? {
        
        let newView = NSTableCellView()
        let cellText = NSTextField()
        newView.textField = cellText

        guard let node = item as? TreeNode else {
            fatalError("Unknown item type")
        }
        
        if tableColumn?.identifier == accountColumnId {
            cellText.stringValue = node.name
            return newView
        }
        
        guard tableColumn?.identifier == balanceColumnId else {
            fatalError("Unexpected column identifier")
        }
        
        cellText.stringValue = node.presentationRecursiveBalance
        cellText.alignment = .right
        cellText.font = NSFont.monospacedDigitSystemFont(
            ofSize: NSFont.systemFontSize,
            weight: NSFont.Weight.regular
        )
        return newView
    }
}

extension TreeOutlineTableView: NSOutlineViewDataSource {
    
    func outlineView(
        _ outlineView: NSOutlineView,
        numberOfChildrenOfItem item: Any?
        ) -> Int {
        if let node = item as? TreeNode {
            return node.children.count
        }
        guard let tree = self.tree else {
            fatalError("Missing Tree")
        }
        return tree.accounts.count
    }
    
    func outlineView(
        _ outlineView: NSOutlineView,
        isItemExpandable item: Any
        ) -> Bool {
        
        if let node = item as? TreeNode {
            return node.children.count > 0
        }
        guard let tree = item as? Tree else {
            fatalError("Unexpected type")
        }
        return tree.accounts.count > 0
    }
    
    func outlineView(
        _ outlineView: NSOutlineView,
        child index: Int,
        ofItem item: Any?
        ) -> Any {
        if let node = item as? TreeNode {
            return node.children[index]
        }
        guard let tree = self.tree else {
            fatalError("Missing Tree")
        }
        return tree.accounts[index]
    }
}
