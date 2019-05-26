//
//  TxDescriptionField.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxDescriptionField: NSTextField {
    
    private static let placeholder = NSLocalizedString(
        "Transaction description",
        comment: "Placeholder in transaction editor"
    )
    
    private var rightConstraint: NSLayoutConstraint? = nil
    private var topConstraint: NSLayoutConstraint? = nil
    private var leftConstraint: NSLayoutConstraint? = nil
    
    private let defaultFrame = NSRect(x: 231, y: 218, width: 321, height: 22)
    
    private let dateField: TxEditorDatePicker

    init(with dateField: TxEditorDatePicker) {
        self.dateField = dateField
        super.init(frame: defaultFrame)
        placeholderString = TxDescriptionField.placeholder
        translatesAutoresizingMaskIntoConstraints = false
        return
    }
    
    override func viewDidMoveToSuperview() {
        guard let superview = superview else {
            rightConstraint?.isActive = false
            rightConstraint = nil
            leftConstraint?.isActive = false
            leftConstraint = nil
            topConstraint?.isActive = false
            topConstraint = nil
            return
        }

        let rightConstraint = NSLayoutConstraint(
            item: self,
            attribute: .right,
            relatedBy: .equal,
            toItem: superview,
            attribute: .right,
            multiplier: 1,
            constant: -TransactionEditor.marginRight
        )
        rightConstraint.isActive = true
        self.rightConstraint = rightConstraint
        
        let topConstraint = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: superview,
            attribute: .top,
            multiplier: 1,
            constant: TransactionEditor.marginTop
        )
        topConstraint.isActive = true
        self.topConstraint = topConstraint

        let leftConstraint = NSLayoutConstraint(
            item: self,
            attribute: .left,
            relatedBy: .equal,
            toItem: dateField,
            attribute: .right,
            multiplier: 1,
            constant: TxEditorDatePicker.marginRight
        )
        leftConstraint.isActive = true
        self.leftConstraint = leftConstraint
        
        return
    }

    required init?(coder: NSCoder) { fatalError("Not implemented") }

}
