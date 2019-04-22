//
//  AccountSelectionCell.swift
//  Amatino
//
//  Created by Hugh Jeremy on 22/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation

import Foundation
import Cocoa

// Autocompletion: https://stackoverflow.com/questions/12353880/nstextfield-complete


class AccountSelectionCell: NSTextFieldCell {
    
    /*override func fieldEditor(for controlView: NSView) -> NSTextView? {
        let editor = NSTextView()
        editor.isFieldEditor = true
        return editor
    }*/

    /*override func fieldEditor(for controlView: NSView) -> NSTextView? {
        let editor = AccountSelectionFieldEditor()
        editor.focusRingType = .exterior
        return editor
    }*/
    
    /*
    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        super.drawInterior(withFrame: cellFrame, in: controlView)
        guard controlView.window?.firstResponder == self.fieldEditor(for: controlView) else { return }
        print("DRAW")
        super.drawFocusRingMask(withFrame: cellFrame, in: controlView)
    }*/
}
