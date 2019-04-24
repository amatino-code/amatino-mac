//
//  AccountSelectionPopUp.swift
//  Amatino
//
//  Created by Hugh Jeremy on 21/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class AccountSelectionPopUp: NSPopUpButton {

    private let items: Array<AccountSelection.Item>
    private let optional: Bool
    
    private static let defaultNoneTitle = "-"
    
    private let optionalItem: NSMenuItem
    
    private var notificationCallback: ((AccountSelection.Item?) -> Void)?
    private var lastSelectedItem: NSMenuItem? = nil
    
    public var selectedOption: AccountSelection.Item? {
        get {
            guard let item = self.selectedItem as? AccountSelection.Item else {
                return nil
            }
            return item
        } set(other) {
            self.select(other)
            lastSelectedItem = other
            return
        }
    }

    private let warning = "AccountSelectionPopUp must control its own items"
    
    init (
        in frame: NSRect,
        offering items: Array<AccountSelection.Item>,
        optional: Bool = false,
        noneTitle: String? = nil
    ) {
        self.items = items
        self.optional = optional
        self.optionalItem = NSMenuItem(
            title: noneTitle ?? AccountSelectionPopUp.defaultNoneTitle,
            action: nil,
            keyEquivalent: ""
        )
        super.init(frame: frame, pullsDown: false)
        if optional { menu?.addItem(optionalItem) }
        for item in items { menu?.addItem(item) }
        return
    }
    
    public func registerCallbackOnChange(
        _ callback: @escaping (AccountSelection.Item?) -> Void
        ) {
        self.notificationCallback = callback
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willOpenMenu(_ menu: NSMenu, with event: NSEvent) {
        if let lastSelectedItem = lastSelectedItem {
            select(lastSelectedItem)
        } else {
            select(items[0])
        }
        super.willOpenMenu(menu, with: event)
        return
    }

    override func didCloseMenu(_ menu: NSMenu, with event: NSEvent?) {
        guard let callback = notificationCallback else {
            fatalError("Notification missing")
        }
        callback(self.selectedOption)
        lastSelectedItem = selectedItem
        super.didCloseMenu(menu, with: event)
        return
    }
    
    public func clearSelection() {
        if !optional { return }
        self.lastSelectedItem = optionalItem
        return
    }
    
    override func select(_ item: NSMenuItem?) {
        lastSelectedItem = item
        super.select(item)
        return
    }

    override func addItem(withTitle title: String) { fatalError(warning) }
    override func removeAllItems() { fatalError(warning) }
    override func removeItem(at index: Int) { fatalError(warning) }
    override func removeItem(withTitle title: String) { fatalError(warning) }
    override func addItems(withTitles itemTitles: [String]) {
        fatalError(warning)
    }

}
