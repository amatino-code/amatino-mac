//
//  TxEditorUnitSelection.swift
//  Amatino
//
//  Created by Hugh Jeremy on 25/5/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class TxEditorUnitSelection: GlobalUnitSelection {
    
    let defaultFrame = NSMakeRect(18, 13, 156, 25)
    
    private var leftConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    
    init(session: Session) {
        super.init(frame: defaultFrame, session: session)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) { fatalError("not implemented") }
    
}
