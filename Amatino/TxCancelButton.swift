//
//  TxCancelButton.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEditorCancelButton: NSButton {
    
    let buttonTitle = NSLocalizedString(
        "Discard changes",
        comment: "Discard Transaction changes in the Transaction editor"
    )
    
    private let saveButton: NSButton
    private let defaultFrame = NSRect(x: 403, y: 9, width: 82, height: 32)
    
    private var rightConstraint: NSLayoutConstraint? = nil
    private var bottomConstraint: NSLayoutConstraint? = nil
    
    
    init(saveButton: NSButton) {
        self.saveButton = saveButton
        super.init(frame: defaultFrame)
        isEnabled = true
        isBordered = true
        keyEquivalent = String(buttonTitle.first ?? "d")
        title = buttonTitle
        setButtonType(.momentaryPushIn)
        bezelStyle = .rounded
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        
        guard superview != nil else {
            rightConstraint?.isActive = false
            rightConstraint = nil
            bottomConstraint?.isActive = false
            bottomConstraint = nil
            return
        }

        rightConstraint = NSLayoutConstraint(
            item: self,
            attribute: .right,
            relatedBy: .equal,
            toItem: saveButton,
            attribute: .left,
            multiplier: 1,
            constant: -TxEditorSaveButton.marginLeft
        )
        rightConstraint?.isActive = true
        
        bottomConstraint = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: saveButton,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        bottomConstraint?.isActive = true

        return
    }

}
