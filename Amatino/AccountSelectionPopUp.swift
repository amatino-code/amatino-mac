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

    let items: Array<AccountSelection.Item>
    
    private var notificationCallback: ((AccountSelection.Item) -> Void)?
    
    public var selectedOption: AccountSelection.Item {
        get {
            guard let item = self.selectedItem as? AccountSelection.Item else {
                fatalError("Unexpected item type")
            }
            return item
        } set(other) {
            self.select(other)
            return
        }
    }

    private let warning = "AccountSelectionPopUp must control its own items"
    
    init (in frame: NSRect, offering items: Array<AccountSelection.Item>) {
        self.items = items
        super.init(frame: frame, pullsDown: false)
        for item in items { menu?.addItem(item) }
        return
    }
    
    public func registerCallbackOnChange(
        _ callback: @escaping (AccountSelection.Item) -> Void
        ) {
        self.notificationCallback = callback
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didCloseMenu(_ menu: NSMenu, with event: NSEvent?) {
        guard let callback = notificationCallback else {
            fatalError("Notification missing")
        }
        callback(self.selectedOption)
    }

    override func addItem(withTitle title: String) { fatalError(warning) }
    override func removeAllItems() { fatalError(warning) }
    override func removeItem(at index: Int) { fatalError(warning) }
    override func removeItem(withTitle title: String) { fatalError(warning) }
    override func addItems(withTitles itemTitles: [String]) {
        fatalError(warning)
    }

}
