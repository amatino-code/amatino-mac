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

    private let deletionView: DeleteAccountView
    
    init(withTarget target: AccountRepresentative, in tree: Tree) {
        self.target = target
        self.tree = tree
        self.deletionView = DeleteAccountView()
        super.init(nibName: nil, bundle: nil)
        return
    }
    
    override func loadView() {
        self.view = deletionView
        if let account = self.target as? Account {
            deletionView.stopShowingProgress()
            accountReadyCallback(error: nil, account: account)
            return
        }
        deletionView.showProgress()
        Account.retrieve(
            from: tree.entity,
            withId: target.accountId,
            then: accountReadyCallback
        )
        return
    }
    
    private func accountReadyCallback(error: Error?, account: Account?) {
        DispatchQueue.main.async {
            self.deletionView.stopShowingProgress()
            guard let account = account else {
                let _ = GenericErrorController(
                    displaying: error,presentedBy: self
                )
                return
            }
            self.deletionView.stopShowingProgress()
            let deleteView = DeleteAccountControlView(
                frame: NSMakeRect(
                    0,
                    0,
                    self.deletionView.frame.width,
                    self.deletionView.frame.height
                ),
                withTarget: account,
                in: self.tree
            )
            self.deletionView.addSubview(deleteView)
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
