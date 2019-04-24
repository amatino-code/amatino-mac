//
//  ParentSelection.swift
//  Amatino
//
//  Created by Hugh Jeremy on 8/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class ParentSelection: AccountSelection {

    private static let noParentTitle = NSLocalizedString(
        "None (New top-level Account)",
        comment: "In the context of choosing a new Account parent"
    )

    init(frame frameRect: NSRect, tree: Tree) {
        super.init(
            frame: frameRect,
            tree: tree,
            optional: true,
            noneTitle: ParentSelection.noParentTitle
        )
        return
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
