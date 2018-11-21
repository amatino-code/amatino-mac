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
        
        self.addSubview(scrollView)
        outline.reloadData()
        return
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func load(_ tree: Tree) { outline.load(tree); return }
    public func item(atRow row: Int) -> Any? { return outline.item(atRow: row) }

}
