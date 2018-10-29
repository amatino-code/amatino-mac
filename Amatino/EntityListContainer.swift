//
//  EntityListContainer.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

class EntityListContainer: NSViewController {
    
    let board = NSStoryboard(name: NSStoryboard.Name(
        rawValue: "Entities"
    ), bundle: nil)
    let entityLoadScene = NSStoryboard.SceneIdentifier("entityLoadView")
    

    public var session: Session? = nil
    
    override func viewDidLoad() {

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
        insertChildViewController(entityLoadingView, at: 0)
        view.addSubview(entityLoadingView.view)
        
        return

    }
    
}
