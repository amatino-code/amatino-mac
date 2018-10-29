//
//  Amatino Swift
//  TreeOutlineContainerView.swift
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class TreeOutlineContainerView: NSViewController {

    let board = NSStoryboard(name: NSStoryboard.Name(
        rawValue: "Accounting"
    ), bundle: nil)
    let entityLoadScene = NSStoryboard.SceneIdentifier("treeOutlineLoadView")

    override func viewDidLoad() {
        
        view.wantsLayer = true

        let loadingView = board.instantiateController(
            withIdentifier: entityLoadScene
            ) as! NSViewController
        loadingView.view.wantsLayer = true
        insertChildViewController(loadingView, at: 0)
        view.addSubview(loadingView.view)
        
    }
    
}
