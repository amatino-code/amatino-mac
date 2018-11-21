//
//  Amatino Swift
//  TreeOutlineLoading.swift
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

class TreeOutlineLoadingController: NSViewController {

    private let entity: Entity
    private let loadingView: TreeOutlineLoadingView
    
    private var loadedTree: Tree?
    private var loadedGlobalUnit: GlobalUnit?

    init(loadingTreeOf entity: Entity) {
        
        self.entity = entity
        
        loadingView = TreeOutlineLoadingView(frame: NSMakeRect(0, 0, 10, 10))

        super.init(nibName: nil, bundle: nil)
        
        TreeUnit(entity: entity).retrieve( callback: { [unowned self]
            (error, globalUnit) in
            guard let unit = globalUnit else {
                fatalError("Unhandled Unit retrieval error")
            }
            self.loadedGlobalUnit = unit
            Tree.retrieve(
                entity: entity,
                globalUnit: unit,
                callback: self.treeReadyCallback
            )
        })
        
    
        return
    }
    
    override func viewDidLoad() {
        loadingView.frame = parent!.view.bounds
        return
    }
    
    override func loadView() {
        self.view = loadingView
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func treeReadyCallback(error: Error?, tree: Tree?) {
        guard let tree = tree else {
            let _ = GenericErrorView(displaying: error ?? AmatinoAppError())
            return
        }
        guard let unit = loadedGlobalUnit else { fatalError("Missing unit") }
        loadedTree = tree
        guard let container = parent as? TreeOutlineContainerController else {
            fatalError("Missing container parent")
        }
        DispatchQueue.main.async {
            container.transition(
                to: tree,
                denominatedIn: unit,
                from: self
            )
        }
        return
    }

    override func viewWillAppear() {
        loadingView.startAnimation()
        return
    }
    
    override func viewDidDisappear() {
        loadingView.stopAnimation()
        return
    }

}
