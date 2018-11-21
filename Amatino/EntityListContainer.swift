//
//  EntityListContainer.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

class EntityListContainer: NSViewController {
    
    let board = NSStoryboard(name: "Entities", bundle: nil)
    let entityLoadScene = "entityLoadView"
    

    public var session: Session? = nil
    
    override func viewDidLoad() {
        
        view.wantsLayer = true

        guard let _ = (
            NSApplication.shared.delegate as? AppDelegate
        )?.login?.session else { fatalError(
            "Entity list view initialised without a session"
            ) }
        
        guard let entityLoadingView = board.instantiateController(
            withIdentifier: entityLoadScene
            ) as? EntitiesLoadingView else {
                fatalError("Could not cast EntitiesLoadingView")
        }
        entityLoadingView.view.wantsLayer = true
        insertChild(entityLoadingView, at: 0)
        view.addSubview(entityLoadingView.view)
        
        return

    }
    
}
