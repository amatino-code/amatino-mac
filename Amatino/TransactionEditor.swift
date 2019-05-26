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
    
    public static let marginRight = CGFloat(20)
    public static let marginLeft = CGFloat(20)
    public static let marginTop = CGFloat(20)
    public static let marginBottom = CGFloat(12)
    
    public static let font = LedgerTableView.font
    public static let monospacedFont = LedgerTableView.monospacedFont

    let defaultFrame = NSRect(x: 0, y: 0, width: 572, height: 261)

    private let dateField = TxEditorDatePicker()
    private let descriptionField: TxDescriptionField
    private let entryTable = TxEntryTable()
    private let saveButton = TxEditorSaveButton()
    private let cancelButton: TxEditorCancelButton
    private let loadingIndicator = TxLoadingIndicator()
    private let entryTableScrollView: TxEntryTableScrollView
    //private let globalUnitSelection: TxEditorUnitSelection

    private var editedTransaction: Transaction? = nil
    
    public var cancelAction: (() -> Void)? = nil

    init() {
        cancelButton = TxEditorCancelButton(saveButton: saveButton)
        descriptionField = TxDescriptionField(with: dateField)
        entryTableScrollView = TxEntryTableScrollView(
            datePicker: dateField,
            saveButton: saveButton,
            table: entryTable
        )
        //globalUnitSelection = GlobalUnitSelection(session: session)
        
        super.init(frame: defaultFrame)
        
        cancelButton.action = #selector(self.closeEditor)
        
        entryTableScrollView.hasVerticalScroller = true
        entryTableScrollView.hasHorizontalScroller = false
        entryTableScrollView.documentView = entryTable
        
        addSubview(dateField)
        addSubview(descriptionField)
        addSubview(saveButton)
        addSubview(entryTableScrollView)
        addSubview(cancelButton)
        addSubview(loadingIndicator)
        //addSubview(globalUnitSelection)
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
        return
    }
    
    @objc private func closeEditor() { cancelAction?(); return }
    
    required init?(coder decoder: NSCoder) { fatalError("Not implemented") }

}
