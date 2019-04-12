//
//  NoEntitiesView.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

class NoEntitiesView: NSViewController {
    
    let segueToEntityListId = "noEntitiesToSomeEntities"
    
    var entityWindowController: EntityWindowController? = nil

    @IBOutlet weak var creationStack: NSStackView!
    @IBOutlet weak var createStack: NSStackView!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    override func viewWillAppear() {
        creationStack.isHidden = true
        createStack.isHidden = false
        progressIndicator.stopAnimation(nil)
    }
    
    override func viewDidAppear() {
        entityWindowController = self.view.window?.windowController as?
            EntityWindowController
        guard entityWindowController != nil else { fatalError(
            "AccountingWindowController missing!"
        ) }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard let entityWindowController = entityWindowController else {
            fatalError("Entity Window Controller missing")
        }
        if let destination = segue.destinationController as?
            CreateEntityPopover {
                guard entityWindowController.environmentReady == true else {
                    fatalError("Attempt create entity before environment ready")
                }
                guard let session = entityWindowController.session else {
                    fatalError("Missing Entity Window Controller session")
                }
                destination.loadEnvironment(
                    session: session,
                    originator: self
                )
                return
            }
    }
    
    func createEntity(entityArguments: Entity.CreateArguments) {
        
        creationStack.isHidden = false
        createStack.isHidden = true
        progressIndicator.startAnimation(nil)
        
        guard let entityWindowController = entityWindowController else {
            fatalError("Missing entityWindowController")
        }
        
        guard let session = entityWindowController.session else {
            fatalError("Missing Session")
        }
        
        Entity.create(
            authenticatedBy: session,
            withArguments: entityArguments,
            then: newEntityReadyCallback
        )
        return
    }
    
    private func newEntityReadyCallback(error: Error?, entity: Entity?) {
        guard let _ = entity else {
            fatalError("Unhandled Entity creation error")
        }
        
        guard let controller = entityWindowController else {
            fatalError("Missing entity window controller")
        }
        
        DispatchQueue.main.async {
            controller.reloadEntityList({ () in
                self.performSegue(
                    withIdentifier: self.segueToEntityListId,
                    sender: self
                )
            })
        }

        return
    }
    
}
