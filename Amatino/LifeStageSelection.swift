//
//  LifeStageSelection.swift
//  Amatino
//
//  Created by Hugh Jeremy on 29/10/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class EntityLifeStageSelection: NSPopUpButton {
    
    public var selectedScope: EntityListScope {
        get {
            guard let title = self.titleOfSelectedItem else {
                fatalError("Scope selection item title missing")
            }
            guard let scope = EntityListScope(
                rawValue: title.lowercased()
            ) else {
                fatalError("Scope selection item title invalid")
            }
            return scope
        }
    }

    override init(frame buttonFrame: NSRect, pullsDown flag: Bool) {
        super.init(frame: buttonFrame, pullsDown: flag)
        populate()
        return
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        populate()
        return
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        populate()
        return
    }
    
    private func populate() {
        removeAllItems()
        let scopeList: [EntityListScope] = [.active, .deleted, .all]
        let _ = scopeList.map{
            self.addItem(withTitle:
                String($0.rawValue.capitalized[$0.rawValue.startIndex]) +
                $0.rawValue[$0.rawValue.index(
                    $0.rawValue.startIndex,
                    offsetBy: 1
                )..<$0.rawValue.endIndex]
        )}
        return
    }
    
    
}
