//
//  Amatino Swift
//  TreeOutlineView.swift
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class TreeOutlineView: NSViewController {
    
    var entity: Entity? = nil
    
    override func viewDidLoad() {
        view.wantsLayer = true
    }
    
    public func loadEntity(entity: Entity) {
        
    }
    
    override func viewWillAppear() {
        //guard entity != nil else { fatalError("Attempt to load TreeOutline with no loaded entity") }
        
    }
    
}

