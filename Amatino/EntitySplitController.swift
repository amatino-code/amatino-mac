//
//  Amatino Swift
//  EntitySplitView.swift
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class EntitySplitController: NSSplitViewController {
    
    let entity: Entity
    let outline: TreeOutlineContainerController
    
    init(displaying entity: Entity) {
        self.entity = entity
        
        outline = TreeOutlineContainerController(displaying: entity)
        let outlineSplitView = NSSplitViewItem(viewController: outline)
        super.init(nibName: nil, bundle: nil)
        addSplitViewItem(outlineSplitView)

        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
