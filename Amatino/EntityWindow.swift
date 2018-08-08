//
//  EntityWindow.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//


import Foundation
import Cocoa
 

class EntityWindowController: NSWindowController {
    
    @IBOutlet weak var statusBar: EntityStatusBar!
    
    var entity: Entity? = nil
    var session: Session? = nil
    
    func loadEnvironment(_ entity: Entity, _ session: Session) {
        self.entity = entity
        self.session = session
        statusBar.loadEntity(entity: entity)
        return
    }

}
