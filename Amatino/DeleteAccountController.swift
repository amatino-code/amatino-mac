//
//  DeleteAccountController.swift
//  Amatino
//
//  Created by Hugh Jeremy on 17/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class DeleteAccountController: NSViewController {
    
    private let target: AccountRepresentative
    private let tree: Tree
    
    init(withTarget target: AccountRepresentative, in tree: Tree) {
        self.target = target
        self.tree = tree
        super.init(nibName: nil, bundle: nil)
        return
    }
    
    override func loadView() {
        self.view = DeleteAccountView(withTarget: target, in: tree)
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
