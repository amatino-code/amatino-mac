//
//  TypeSelection.swift
//  Amatino
//
//  Created by Hugh Jeremy on 8/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation

class TypeSelection: AMPopUpButton {
    
    private let doesPullDown = false
    private let startType = AccountType.asset
    
    public var selectedType: AccountType {
        get { // Force unwrap acceptable here as names are constants
            guard let type = selectedItem?.representedObject as? AccountType
                else
            { fatalError("Represented object is not an account type") }
            return type
        }
    }
    
    public func select(_ type: AccountType) {
        selectItem(withTitle: AccountType.nameFor(type))
        return
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect, pullsDown: doesPullDown)
        let _ = AccountType.allNames.map { self.addItem(withTitle: $0) }
        let _ = itemArray.map {
            $0.representedObject = AccountType.typeWith(name: $0.title)
        }
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
