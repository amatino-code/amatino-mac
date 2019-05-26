//
//  TxSaveButton.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEditorSaveButton: NSButton {
    
    public static let marginLeft = CGFloat(10)
    public static let marginTop = CGFloat(10)
    
    let buttonTitle = NSLocalizedString(
        "Record Transaction",
        comment: "Execute Transaction save in Transaction editor"
    )
    
    let defaultFrame = NSRect(x: 489, y: 9, width: 70, height: 32)
    
    private var rightConstraint: NSLayoutConstraint? = nil;
    private var bottomConstraint: NSLayoutConstraint? = nil;
    
    init() {
        super.init(frame: defaultFrame)
        isEnabled = true
        isBordered = true
        keyEquivalent = "\r"
        title = buttonTitle
        setButtonType(.momentaryPushIn)
        bezelStyle = .rounded
        translatesAutoresizingMaskIntoConstraints = false
        return
    }
    
    override func viewDidMoveToSuperview() {

        guard let superview = superview else {
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
            toItem: superview,
            attribute: .right,
            multiplier: 1,
            constant: -TransactionEditor.marginRight
        )
        rightConstraint?.isActive = true
        
        bottomConstraint = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: superview,
            attribute: .bottom,
            multiplier: 1,
            constant: -TransactionEditor.marginBottom
        )
        bottomConstraint?.isActive = true
        
        sizeToFit()
        return
    }

    required init?(coder: NSCoder) { fatalError("Not implemented") }
    
}
