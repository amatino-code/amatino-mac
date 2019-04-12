//
//  CreateAccount.swift
//  Amatino
//
//  Created by Hugh Jeremy on 5/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class CreateAccountView: NSView {
    
    public let entity: Entity

    private let nameLabel: Label
    private let parentLabel: Label
    private let typeLabel: Label
    private let denominationLabel: Label
    private let descriptionLabel: Label

    private let nameField: NSTextField
    private let parentField: ParentSelection
    private let typeField: TypeSelection
    private let denominationField: GlobalUnitSelection
    private let descriptionField: NSTextField
    private let createButton: PushButton

    private let startFrame = NSMakeRect(0, 0, 284, 287)
    private let nameLabelFrame = NSMakeRect(13, 254, 40, 17)
    private let nameFieldFrame = NSMakeRect(93, 251, 171, 22)
    private let parentLabelFrame = NSMakeRect(13, 220, 44, 17)
    private let parentFieldFrame = NSMakeRect(91, 215, 176, 26)
    private let typeLabelFrame = NSMakeRect(13, 185, 34, 17)
    private let typeFieldFrame = NSMakeRect(91, 178, 176, 26)
    private let denominationLabelFrame = NSMakeRect(13, 145, 88, 17)
    private let denominationFieldFrame = NSMakeRect(117, 139, 150, 26)
    private let descriptionLabelFrame = NSMakeRect(13, 107, 74, 17)
    private let descriptionFieldFrame = NSMakeRect(93, 52, 171, 72)
    private let createButtonFrame = NSMakeRect(136, 9, 134, 32)

    private let nameLabelText = NSLocalizedString("Name", comment: "")
    private let parentLabelText = NSLocalizedString("Parent", comment: "")
    private let typeLabelText = NSLocalizedString("Type", comment: "")
    private let denominationLabelText = NSLocalizedString(
        "Denomination",
        comment: ""
    )
    private let descriptionLabelText = NSLocalizedString(
        "Description",
        comment: ""
    )
    private let createButtonText = NSLocalizedString(
        "Create Account",
        comment: ""
    )
    
    private let createSignal: () -> Void

    init(
        entity: Entity,
        tree: Tree,
        createSignal: @escaping () -> Void
    ) {

        self.entity = entity

        nameLabel = Label(frame: nameLabelFrame)
        nameLabel.stringValue = nameLabelText
        nameField = NSTextField(frame: nameFieldFrame)
        parentLabel = Label(frame: parentLabelFrame)
        parentLabel.stringValue = parentLabelText
        parentField = ParentSelection(frame: parentFieldFrame, tree: tree)
        typeLabel = Label(frame: typeLabelFrame)
        typeLabel.stringValue = typeLabelText
        typeField = TypeSelection(frame: typeFieldFrame)
        denominationLabel = Label(frame: denominationLabelFrame)
        denominationLabel.stringValue = denominationLabelText
        denominationField = GlobalUnitSelection(
            frame: denominationFieldFrame,
            session: entity.session
        )
        descriptionLabel = Label(frame: descriptionLabelFrame)
        descriptionLabel.stringValue = descriptionLabelText
        descriptionField = NSTextField(frame: descriptionFieldFrame)
        descriptionField.placeholderString = NSLocalizedString(
            "Optional", comment: ""
        )

        createButton = PushButton(frame: createButtonFrame)
        createButton.title = createButtonText
        createButton.keyEquivalent = "\r"
        createButton.isEnabled = false
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        createButton.attributedTitle = NSAttributedString(
            string: createButtonText,
            attributes: [
                .font: NSFont.systemFont(
                    ofSize: NSFont.systemFontSize
                ),
                .paragraphStyle: paragraph
            ]
        )

        self.createSignal = createSignal

        super.init(frame: startFrame)

        addSubview(nameLabel)
        addSubview(nameField)
        addSubview(parentLabel)
        addSubview(parentField)
        addSubview(typeLabel)
        addSubview(typeField)
        addSubview(denominationLabel)
        addSubview(denominationField)
        addSubview(descriptionLabel)
        addSubview(descriptionField)
        addSubview(createButton)
        
        denominationField.readyCallback = unitsReadyCallback
        
        createButton.action = #selector(self.sendCreateSignal)
        
        parentField.action = #selector(self.parentSelected)
        
        self.wantsLayer = true

        return
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func unitsReadyCallback() {
        DispatchQueue.main.async {
            self.createButton.isEnabled = true
        }
    }
    
    @objc private func sendCreateSignal() {
        createSignal()
        return
    }
    
    @objc private func parentSelected() {
        if let node = parentField.selectedNode {
            typeField.select(node.type)
            typeField.isEnabled = false
            return
        }
        typeField.isEnabled = true
        return
    }

    public func readUserInput() throws -> Account.CreateArguments {
        let unit = try denominationField.retrieveSelectedUnit()
        let arguments: Account.CreateArguments
        if let parent = parentField.selectedNode {
            arguments = try Account.CreateArguments(
                name: nameField.stringValue,
                parent: parent,
                description: descriptionField.stringValue,
                denomination: unit
            )
        } else {
            arguments = try Account.CreateArguments(
                name: nameField.stringValue,
                type: typeField.selectedType,
                description: descriptionField.stringValue,
                denomination: unit
            )
        }
        return arguments
    }
}
