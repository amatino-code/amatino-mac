//
//  EntityStatusBar.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

class EntityStatusBar: NSToolbarItem {
    
    var entity: Entity? = nil
    
    func loadEntity(entity: Entity) {
        self.entity = entity
        let underlyingView = view as? NSButton
        do {
            underlyingView?.title = try entity.describe().name
        } catch {
            fatalError("Unhandled entity retrieval error")
        }
        return
    }

}
