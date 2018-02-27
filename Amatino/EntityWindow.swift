//
//  EntityWindow.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//


import Foundation
import Cocoa
import AmatinoApi

class EntityWindowController: NSWindowController {
    
    @IBOutlet weak var statusBar: EntityStatusBar!
    
    private var entity: Entity? = nil
    
    func loadEntity(_ entity: Entity) {
        self.entity = entity
        statusBar.loadEntity(entity: entity)
        return
    }

}
