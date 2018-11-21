//
//  AccountingWindow.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//


import Foundation
import Cocoa
 

class AccountingWindowController: NSWindowController {
    
    private static let defaultWidth = CGFloat(832)
    private static let defaultHeight = CGFloat(397)
    
    let entity: Entity
    
    init(displaying entity: Entity) {

        self.entity = entity
        
        let content = EntitySplitController(displaying: entity)
        
//        let screenHeight = NSScreen.main?.frame.height ?? CGFloat(1024)
//        let screenWidth = NSScreen.main?.frame.width ?? CGFloat(768)
//        
//        let frameX = (screenWidth  / 2) - (
//            AccountingWindowController.defaultWidth / 2
//        )
//        let frameY = (screenHeight / 2) - (
//            AccountingWindowController.defaultHeight / 2
//        )
        
//        let windowFrame = NSMakeRect(
//            frameX,
//            frameY,
//            AccountingWindowController.defaultWidth,
//            AccountingWindowController.defaultHeight
//        )

        let window = NSWindow(contentViewController: content)
        
        window.title = entity.name
    
        window.styleMask = [
            .titled, .resizable, .closable, .miniaturizable
        ]
        
        super.init(window: window)
        
        
        

        
        return
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
