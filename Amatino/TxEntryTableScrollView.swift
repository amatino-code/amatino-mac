//
//  TxEntryTableScrollView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 25/5/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEntryTableScrollView: NSScrollView {
    
    private let defaultFrame = NSRect(x: 20, y: 49, width: 532, height: 154)
    
    private var rightConstraint: NSLayoutConstraint? = nil
    private var topConstraint: NSLayoutConstraint? = nil
    private var leftConstraint: NSLayoutConstraint? = nil
    private var bottomConstraint: NSLayoutConstraint? = nil
    
    private let datePicker: TxEditorDatePicker
    private let saveButton: TxEditorSaveButton
    private let entryTable: TxEntryTable
    
    init(
        datePicker: TxEditorDatePicker,
        saveButton: TxEditorSaveButton,
        table: TxEntryTable
    ) {

        self.datePicker = datePicker
        self.saveButton = saveButton
        self.entryTable = table

        super.init(frame: defaultFrame)

        translatesAutoresizingMaskIntoConstraints = false
        self.borderType = .lineBorder
        
        return
    }
    
    override func viewDidMoveToSuperview() {
        guard let superview = superview else {
            let _ = [
                rightConstraint,
                leftConstraint,
                topConstraint,
                bottomConstraint
                ].map { (constraint) -> Void in
                    constraint?.isActive = false
            }
            rightConstraint = nil
            leftConstraint = nil
            bottomConstraint = nil
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
        
        let leftConstraint = NSLayoutConstraint(
            item: self,
            attribute: .left,
            relatedBy: .equal,
            toItem: superview,
            attribute: .left,
            multiplier: 1,
            constant: TransactionEditor.marginLeft
        )
        leftConstraint.isActive = true
        self.leftConstraint = leftConstraint
        
        let topConstraint = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: datePicker,
            attribute: .bottom,
            multiplier: 1,
            constant: TxEditorDatePicker.marginBottom
        )
        topConstraint.isActive = true
        self.topConstraint = topConstraint
        
        let bottomConstraint = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: saveButton,
            attribute: .top,
            multiplier: 1,
            constant: -TxEditorSaveButton.marginTop
        )
        bottomConstraint.isActive = true
        self.topConstraint = bottomConstraint
    
        entryTable.sizeToFit()
        
        return
    }
    
    required init?(coder: NSCoder) { fatalError("not implemented") }
    
}
