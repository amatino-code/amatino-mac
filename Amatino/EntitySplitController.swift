//
//  Amatino Swift
//  EntitySplitView.swift
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class EntitySplitController: NSSplitViewController {
    
    private let entity: Entity
    private let outline: TreeOutlineContainerController
    private let ledger: LedgerController
    private let outlineSplitItem: NSSplitViewItem
    private let ledgerSplitItem: NSSplitViewItem
    
    init(displaying entity: Entity) {
        self.entity = entity
        
        ledger = LedgerController()
        outline = TreeOutlineContainerController(
            displaying: entity,
            associatedWith: ledger
        )
        outlineSplitItem = NSSplitViewItem(viewController: outline)
        ledgerSplitItem = NSSplitViewItem(viewController: ledger)
        super.init(nibName: nil, bundle: nil)

        splitView.isVertical = true
        addSplitViewItem(outlineSplitItem)
        addSplitViewItem(ledgerSplitItem)

        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
