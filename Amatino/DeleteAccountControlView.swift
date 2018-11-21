//
//  DeleteAccountControlView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 15/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class DeleteAccountControlView: NSView {

    private static let defaultFrame = NSMakeRect(0, 0, 413, 155)

    private let moveEntriesLabelFrame = NSMakeRect(21, 117, 127, 17)
    private let moveChildrenLabelFrame = NSMakeRect(21, 86, 171, 17)
    private let moveEntriesFrame = NSMakeRect(206, 111, 190, 26)
    private let moveChildrenFrame = NSMakeRect(206, 80, 190, 26)
    private let deleteChildrenFrame = NSMakeRect(21, 54, 114, 18)
    private let cancelFrame = NSMakeRect(184, 13, 82, 32)
    private let deleteFrame = NSMakeRect(266, 13, 133, 32)

    private let target: Account
    private let tree: Tree

    private let moveEntriesLabel: Label
    private let moveChildrenLabel: Label
    private let deleteChildrenCheck: AMButton
    private let moveEntriesSelection: AccountSelection
    private let moveChildSelection: OptionalAccountSelection
    private let cancelButton: PushButton
    private let deleteButton: PushButton
    
    private let cancelText = NSLocalizedString("Cancel", comment: "")
    private let deleteText = NSLocalizedString("Delete Account", comment: "")

    init(
        frame frameRect: NSRect,
        withTarget target: Account,
        in tree: Tree
    ) {
        self.target = target
        self.tree = tree

        moveEntriesLabel = Label(frame: moveEntriesLabelFrame)
        moveChildrenLabel = Label(frame: moveChildrenLabelFrame)
        deleteChildrenCheck = AMButton(
            checkboxWithTitle: "Delete children",
            target: nil,
            action: #selector(self.childDeleteChecked)
        )
        deleteChildrenCheck.frame = deleteChildrenFrame
        moveEntriesSelection = ParentSelection(
            frame: moveEntriesFrame,
            tree: tree
        )
        moveChildSelection = ParentSelection(
            frame: moveChildrenFrame,
            tree: tree
        )
        cancelButton = PushButton(frame: cancelFrame)
        deleteButton = PushButton(frame: deleteFrame)
        
        cancelButton.title = cancelText
        cancelButton.keyEquivalent = "c"
        deleteButton.title = deleteText
        deleteButton.keyEquivalent = "\r"
        
        super.init(frame: frameRect)
        
        addSubview(moveEntriesLabel)
        addSubview(moveChildrenLabel)
        addSubview(deleteChildrenCheck)
        addSubview(moveEntriesSelection)
        addSubview(moveChildSelection)
        addSubview(cancelButton)
        addSubview(deleteButton)

        return
    }

    convenience init(
        withTarget target: Account,
        in tree: Tree
        ) {
        self.init(
            frame: DeleteAccountControlView.defaultFrame,
            withTarget: target,
            in: tree
        )
        return
    }

    @objc private func childDeleteChecked() {
        if deleteChildrenCheck.state == .on {
            moveChildSelection.selectNone()
            moveChildSelection.isEnabled = false
            return
        }
        moveChildSelection.isEnabled = true
        return
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
