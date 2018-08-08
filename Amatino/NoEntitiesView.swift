//
//  NoEntitiesView.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

class NoEntitiesView: NSViewController {
    
    let segueToEntityListId = NSStoryboardSegue.Identifier("noEntitiesToSomeEntities")
    
    var accountingController: AccountingWindowController? = nil

    @IBOutlet weak var creationStack: NSStackView!
    @IBOutlet weak var createStack: NSStackView!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    override func viewWillAppear() {
        creationStack.isHidden = true
        createStack.isHidden = false
        progressIndicator.stopAnimation(nil)
    }
    
    override func viewDidAppear() {
        accountingController = self.view.window?.windowController as? AccountingWindowController
        guard accountingController != nil else { fatalError("AccountingWindowController missing!") }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController as? CreateEntityPopover {
            guard accountingController!.environmentReady == true else { fatalError("Attempt create entity before environment ready") }
            destination.loadEnvironment(
                session: accountingController!.session!,
                regions: accountingController!.regionList!,
                originator: self)
            return
        }

        if let destination = segue.destinationController as? EntityListView {
            guard accountingController != nil else { fatalError("Accounting controller missing!") }
            destination.setEnvironment(accountingController: accountingController!)
            return
        }

    }
    
    func createEntity(entityArguments: EntityCreateArguments) {
        
        creationStack.isHidden = false
        createStack.isHidden = true
        progressIndicator.startAnimation(nil)
        
        do {
            try _ = Entity(
                attributes: entityArguments,
                session: accountingController!.session!,
                readyCallback: newEntityReadyCallback
            )
        } catch {
            fatalError("Unhandled entity creation error")
        }
        return
    }
    
    private func newEntityReadyCallback(entity: Entity) {
        accountingController!.reloadEntityList({ () in
            self.performSegue(withIdentifier: self.segueToEntityListId, sender: self)
        })
        return
    }
    
}
