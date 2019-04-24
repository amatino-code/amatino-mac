//
//  CreateAccountController.swift
//  Amatino
//
//  Created by Hugh Jeremy on 1/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class CreateAccountController: NSViewController {

    public let createAction: ((Account.CreateArguments, Any?) -> Void)
    public let entity: Entity
    public let tree: Tree
    private var createView: CreateAccountView?
    
    init(
        tree: Tree,
        createAction: @escaping (Account.CreateArguments, Any?) -> Void
    ) {
        self.tree = tree
        self.entity = tree.entity
        self.createAction = createAction
        super.init(nibName: nil, bundle: nil)
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func create() {
        guard let createView = createView else { fatalError("View is absent") }
        let arguments: Account.CreateArguments
        do {
            arguments = try createView.readUserInput()
            createAction(arguments, self)
        } catch {
            createView.shake()
        }
        return
    }
    
    public func prefill(tentativeName name: String) {
        guard let createView = createView else {
            fatalError("Create view not available")
        }
        createView.prefill(tentativeName: name)
        return
    }

    override func loadView() {
        let loadedView = CreateAccountView(
            entity: self.entity,
            tree: tree,
            createSignal: self.create
        )
        self.view = loadedView
        createView = loadedView
        return
    }

}
