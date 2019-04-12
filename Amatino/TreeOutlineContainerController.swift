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
    
    private var ledger: LedgerController? = nil
    
    init(
        displaying entity: Entity,
        associatedWith ledger: LedgerController? = nil
    ) {
        loadingController = TreeOutlineLoadingController(
            loadingTreeOf: entity
        )
        self.ledger = ledger
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
            denominatedIn: unit,
            associatedWith: ledger
        )
        insertChild(outline, at: 0)
        transition(
            from: loadingController,
            to: outline,
            options: .slideLeft,
            completionHandler: nil
        )
        outline.view.leadingAnchor.constraint(
            equalTo: view.leadingAnchor
        ).isActive = true
        outline.view.trailingAnchor.constraint(
            equalTo: view.trailingAnchor
        ).isActive = true
        outline.view.topAnchor.constraint(
            equalTo: view.topAnchor
        ).isActive = true
        outline.view.bottomAnchor.constraint(
            equalTo: view.bottomAnchor
        ).isActive = true
        return
    }
    

}
