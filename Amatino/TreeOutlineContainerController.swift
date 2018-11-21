//
//  Amatino Swift
//  TreeOutlineContainerView.swift
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class TreeOutlineContainerController: NSViewController {
    
    let defaultFrame = NSMakeRect(0, 0, 309, 475)
    let entity: Entity
    let loadingController: TreeOutlineLoadingController
    
    init(displaying entity: Entity) {
        loadingController = TreeOutlineLoadingController(
            loadingTreeOf: entity
        )
        self.entity = entity
        super.init(nibName: nil, bundle: nil)
        return
    }
    
    override func loadView() {
        view = NSView(frame: defaultFrame)
        view.wantsLayer = true
        insertChild(loadingController, at: 0)
        view.addSubview(loadingController.view)
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func transition(
        to tree: Tree,
        denominatedIn unit: GlobalUnit,
        from loadingController: TreeOutlineLoadingController
    ) {
        let outline = TreeOutlineController(
            outlining: tree,
            denominatedIn: unit
        )
        insertChild(outline, at: 0)
        transition(
            from: loadingController,
            to: outline,
            options: .slideLeft,
            completionHandler: nil
        )
        return
    }
    

}
