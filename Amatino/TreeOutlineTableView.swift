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
    
    public var selectedNode: Node? {
        get {
            let selectedItem = item(atRow: selectedRow)
            if selectedItem == nil { return nil }
            guard let ledgerRow = selectedItem as? Node else {
                fatalError("Unexpected item type")
            }
            return ledgerRow
        }
    }
    
    var tree: Tree?
    
    init(frame frameRect: NSRect, outlining tree: Tree) {
        self.tree = tree
        super.init(frame: frameRect)
        let outlineColumn = NSTableColumn(identifier: accountColumnId)
        let balanceColumn = NSTableColumn(identifier: balanceColumnId)
        addTableColumn(outlineColumn)
        addTableColumn(balanceColumn)
        outlineTableColumn = outlineColumn
        outlineColumn.tableView = self
        balanceColumn.tableView = self
        outlineColumn.resizingMask = [.autoresizingMask, .userResizingMask]
        balanceColumn.resizingMask = [.autoresizingMask, .userResizingMask]
        columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        outlineColumn.width = 150
        balanceColumn.width = 50
        delegate = self
        dataSource = self
        headerView = nil
        allowsColumnSelection = false
        usesAlternatingRowBackgroundColors = false
        intercellSpacing = .zero
        selectionHighlightStyle = .sourceList
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
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        superview?.mouseDown(with: event)
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
        let cellFrame = NSMakeRect(0, 0, tableColumn!.width, 20)
        newView.frame = cellFrame
        cellText.frame = newView.bounds
        cellText.backgroundColor = nil
        cellText.isBordered = false
        cellText.isBezeled = false
        cellText.isEditable = false
        cellText.isSelectable = true
        cellText.translatesAutoresizingMaskIntoConstraints = false
        cellText.cell?.lineBreakMode = .byTruncatingMiddle
        newView.addSubview(cellText)
        newView.textField = cellText
        newView.leadingAnchor.constraint(
            equalTo: cellText.leadingAnchor
        ).isActive = true
        newView.trailingAnchor.constraint(
            equalTo: cellText.trailingAnchor
        ).isActive = true
        newView.topAnchor.constraint(
            equalTo: cellText.topAnchor
        ).isActive = true
        newView.bottomAnchor.constraint(
            equalTo: cellText.bottomAnchor
        )

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
