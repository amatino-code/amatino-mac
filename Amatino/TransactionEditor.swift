//
//  TransactionEditor.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class TransactionEditor: NSView {
    
    public static let font = LedgerTableView.font
    public static let monospacedFont = LedgerTableView.monospacedFont

    let defaultFrame = NSRect(x: 0, y: 0, width: 572, height: 261)

    private let dateField = TxEditorDatePicker()
    private let descriptionField = TxDescriptionField()
    private let entryTable = TxEntryTable()
    private let saveButton = TxEditorSaveButton()
    private let cancelButton = TxEditorCancelButton()
    private let loadingIndicator = TxLoadingIndicator()

    private var editedTransaction: Transaction? = nil

    init() {
        super.init(frame: defaultFrame)
        addSubview(dateField)
        addSubview(descriptionField)
        addSubview(entryTable)
        addSubview(saveButton)
        addSubview(cancelButton)
        addSubview(loadingIndicator)
        return
    }

    public func showLoadingIndication() {

        dateField.isHidden = true
        descriptionField.isHidden = true
        entryTable.isHidden = true
        saveButton.isHidden = true
        cancelButton.isHidden = true
        
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimation(self)
        
        return
    }
    
    public func endLoadingIndication() {
    
        dateField.isHidden = false
        descriptionField.isHidden = false
        entryTable.isHidden = false
        saveButton.isHidden = false
        cancelButton.isHidden = false
        
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimation(self)
        
        return
    }
    
    public func load(_ transaction: Transaction) {
        editedTransaction = transaction
        
    }

    
    required init?(coder decoder: NSCoder) { fatalError("Not implemented") }

}
