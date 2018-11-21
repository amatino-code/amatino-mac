//
//  CreateAccountPopover.swift
//  Amatino
//
//  Created by Hugh Jeremy on 1/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class CreateAccountPopover: NSPopover {
    
    let frameWidth = CGFloat(100)
    let frameHeight = CGFloat(100)
    let frameX = CGFloat(0)
    let frameY = CGFloat(0)
    
    init(controller: NSViewController) {
        
        super.init()
        
        let controller = NSViewController()
        controller.view = NSView(
            frame: NSMakeRect(frameX, frameY, frameWidth, frameHeight)
        )
        contentViewController = NSViewController()
        
        
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
