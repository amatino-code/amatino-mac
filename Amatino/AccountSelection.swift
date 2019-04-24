//
//  AccountSelection.swift
//  Amatino
//
//  Created by Hugh Jeremy on 15/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class AccountSelection: NSView {
    
    private let tree: Tree
    private let items: Array<AccountSelection.Item>
    private let textField: AccountSelectionTextField
    private let button: AccountSelectionPopUp
    private let buttonWidth = CGFloat(22)
    private let buttonHeight = CGFloat(22)
    private let buttonRightOffset = CGFloat(-4)
    private let buttonMaxWidth = CGFloat(17)
    private let textLeftOffset = CGFloat(2)
    
    private let optional: Bool

    public var selectedAccount: AccountRepresentative? {
        get {
            if textField.stringValue == "" { return nil }
            if textField.stringValue != button.selectedOption?.hierarchyName {
                return nil
            }
            return button.selectedOption?.targetAccount
        }
    }
    
    public var isFocused: Bool { get { return textField.isFocused } }

    public var action: Selector? {
        get { return button.action }
        set(other) { button.action = other }
    }
    
    private var internalIsEnabled: Bool = true
    public var isEnabled: Bool {
        set(enabled) {
            if (enabled == true) {
                internalIsEnabled = true
                textField.isEnabled = true
                button.isEnabled = true
            } else {
                internalIsEnabled = false
                textField.isEnabled = false
                button.isEnabled = false
            }
        }
        get { return internalIsEnabled }
    }

    
    init(
        frame: NSRect,
        tree: Tree,
        optional: Bool = false,
        noneTitle: String? = nil
    ) {
        self.tree = tree
        self.optional = optional
        
        var items = Array<Item>()
        for topLevel in tree.accounts {
            items.append(Item(offering: topLevel, ancestor: topLevel))
            let _ = topLevel.flatChildren.map( {items.append(
                AccountSelection.Item(offering: $0, ancestor: topLevel)
            )} )
        }
        self.items = items
        
        button = AccountSelectionPopUp(
            in: NSMakeRect(0, 0, buttonWidth, buttonHeight),
            offering: items,
            optional: optional,
            noneTitle: noneTitle
        )

        textField = AccountSelectionTextField(
            offering: items,
            in: frame
        )
        
        super.init(frame: frame)
        
        textField.registerCallbackOnChange(self.textInputDidChange)

        addSubview(button)
        addSubview(textField)

        button.isBordered = false
        button.registerCallbackOnChange(self.menuItemWasSelected)

        // Anchor the button to the right side of the view
        button.translatesAutoresizingMaskIntoConstraints = false

        let buttonRightConstraint = NSLayoutConstraint(
            item: button,
            attribute: .right,
            relatedBy: .equal,
            toItem: self,
            attribute: .right,
            multiplier: 1,
            constant: buttonRightOffset
        )

        let buttonTopConstraint = NSLayoutConstraint(
            item: button,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )

        let buttonBottomConstraint = NSLayoutConstraint(
            item: button,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        
        let buttonLeftConstraint = NSLayoutConstraint(
            item: button,
            attribute: .left,
            relatedBy: .equal,
            toItem: self,
            attribute: .right,
            multiplier: 1,
            constant: (buttonRightOffset - buttonMaxWidth)
        )

        buttonRightConstraint.isActive = true
        buttonTopConstraint.isActive = true
        buttonBottomConstraint.isActive = true
        buttonLeftConstraint.isActive = true
        
        // Restrict the text field width to accomodate the button
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let textLeftConstraint = NSLayoutConstraint(
            item: textField,
            attribute: .left,
            relatedBy: .equal,
            toItem: self,
            attribute: .left,
            multiplier: 1,
            constant: textLeftOffset
        )
        
        let textTopConstraint = NSLayoutConstraint(
            item: textField,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        
        let textBottomConstraint = NSLayoutConstraint(
            item: textField,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        
        let textRightConstraint = NSLayoutConstraint(
            item: textField,
            attribute: .right,
            relatedBy: .equal,
            toItem: self,
            attribute: .right,
            multiplier: 1,
            constant: (buttonRightOffset - buttonMaxWidth)
        )
        
        textTopConstraint.isActive = true
        textLeftConstraint.isActive = true
        textBottomConstraint.isActive = true
        textRightConstraint.isActive = true

        return
    }
    
    public func configureForDisplayInTable() {
        textField.drawsBackground = false
        textField.isBordered = false
        textField.isBezeled = false
        textField.font = LedgerTableView.font
        button.font = LedgerTableView.font
        return
    }
    
    public func configureForFreeFloatingDisplay() {
        textField.drawsBackground = true
        textField.isBordered = true
        textField.font? = NSFont.systemFont(
            ofSize: NSFont.systemFontSize(for: .regular)
        )
        textField.textColor = NSColor.controlTextColor
        return
    }

    private func menuItemWasSelected(_ item: AccountSelection.Item?) {
        if let item = item {
            textField.stringValue = item.hierarchyName
            return
        }
        textField.stringValue = ""
        return
    }
    
    private func textInputDidChange(_ item: AccountSelection.Item) {
        button.selectedOption = item
        return
    }
    
    public func assignNextResponder(_ responder: NSResponder) {
        self.nextResponder = responder
        self.button.nextResponder = responder
        self.textField.nextResponder = responder
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createAccount(tentativelyNamed name: String) {
        let controller = CreateAccountController(
            tree: tree
        ) { (arguments, _) in
            print(arguments)
            return
        }
        
        let popover = NSPopover()
        popover.contentViewController = controller
        popover.behavior = .transient
        popover.show(relativeTo: frame, of: self, preferredEdge: .minY)
        controller.prefill(tentativeName: name)
        return
    }
    
    public func clearSelection() {
        textField.stringValue = ""
        if !self.optional { return }
        button.clearSelection()
        return
    }
    
    public func selectAccount(withId id: Int) {
        for item in self.items {
            if item.targetAccount.accountId == id {
                textField.stringValue = item.hierarchyName
                button.select(item)
                return
            }
        }
        fatalError("Account not found")
    }

    public class Item: NSMenuItem {

        public let ancestor: Node
        public let targetAccount: Node
        public let hierarchyName: String
        
        init(
            offering target: Node,
            ancestor: Node
        ) {
            self.targetAccount = target
            self.ancestor = ancestor
            self.hierarchyName = Item.computeHierarchicalName(
                target,
                ancestor: ancestor
            )
            super.init(title: hierarchyName, action: nil, keyEquivalent: "")
        }
        
        required init(coder decoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private static func computeHierarchicalName(
            _ targetAccount: Node,
            ancestor: Node,
            delimeter: String = ":"
        ) -> String {
            if ancestor.accountId == targetAccount.accountId {
                return ancestor.name
            }
            var handle = ancestor.name
            func recurse(_ node: Node, _ handle: inout String) {
                if node.accountId == targetAccount.accountId {
                    handle += (delimeter + node.name)
                    return
                }
                if (!node.children.map( {$0.accountId} ).contains(
                    targetAccount.accountId
                    )) { return }
                for child in node.children { recurse(child, &handle) }
                return
            }
            recurse(ancestor, &handle)
            return handle
        }
    }
}

