//
//  LedgerAccountInputCell.swift
//  Amatino
//
//  Created by Hugh Jeremy on 17/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerAccountInputCell: NSPopUpButtonCell {
    
    override func drawInterior(
        withFrame cellFrame: NSRect,
        in controlView: NSView
    ) {
        super.drawInterior(withFrame: cellFrame, in: controlView)
        print(cellFrame)
        print(controlView)
        print("Draw interior")
        let text = NSTextField(string: "Hello World")
        controlView.addSubview(text)
        return
    }
    
    override func drawBorderAndBackground(
        withFrame cellFrame: NSRect,
        in controlView: NSView
    ) {
        super.drawInterior(withFrame: cellFrame, in: controlView)
        print(cellFrame)
        print(controlView)
        print("Draw border")
        return
    }

}
