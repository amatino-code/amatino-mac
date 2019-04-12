//
//  TreeOutlineView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 18/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class TreeOutlineView: NSView {
    
    private let outline: TreeOutlineTableView
    private let scrollView: NSScrollView
    
    var clickedRow: Int { get { return outline.clickedRow } }
    var selectedNode: Node? { get { return outline.selectedNode} }
    
    init(frame frameRect: NSRect, outlining tree: Tree) {
        scrollView = NSScrollView(frame: frameRect)
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        outline = TreeOutlineTableView(
            frame: scrollView.bounds,
            outlining: tree
        )

        scrollView.contentView.documentView = outline

        super.init(frame: frameRect)
        
        translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(scrollView)
        
        scrollView.frame = bounds
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(
            equalTo: leadingAnchor
        ).isActive = true
        scrollView.trailingAnchor.constraint(
            equalTo: trailingAnchor
        ).isActive = true
        scrollView.topAnchor.constraint(
            equalTo: topAnchor
        ).isActive = true
        scrollView.bottomAnchor.constraint(
            equalTo: bottomAnchor
        ).isActive = true
        
        outline.reloadData()
        return
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func load(_ tree: Tree) { outline.load(tree); return }
    public func item(atRow row: Int) -> Any? { return outline.item(atRow: row) }
    public func sizeToFit() { outline.sizeToFit() }

}
