//
//  DeleteAccountView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 16/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class DeleteAccountView: NSView {
    
    private static let defaultFrame = NSMakeRect(0, 0, 413, 155)
    
    private let target: AccountRepresentative
    private let tree: Tree
    
    private let progressIndicator: NSProgressIndicator
    private let progressIndicatorFrame = NSMakeRect(24, 24, 32, 32)
    
    init(
        frame frameRect: NSRect,
        withTarget target: AccountRepresentative,
        in tree: Tree
        ) {
        self.target = target
        self.tree = tree
        progressIndicator = NSProgressIndicator(
            frame: progressIndicatorFrame
        )
        super.init(frame: frameRect)
        if let account = target as? Account {
            progressIndicator.isHidden = true
            accountReadyCallback(error: nil, account: account)
            return
        }
        progressIndicator.style = .spinning
        progressIndicator.isIndeterminate = true
        progressIndicator.startAnimation(self)
        progressIndicator.controlSize = .small
        addSubview(progressIndicator)
        Account.retrieve(
            from: tree.entity,
            withId: target.accountId,
            then: self.accountReadyCallback
        )
        return
    }
    
    convenience init(withTarget target: AccountRepresentative, in tree: Tree) {
        self.init(
            frame: DeleteAccountView.defaultFrame,
            withTarget: target,
            in: tree
        )
        return
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func accountReadyCallback(error: Error?, account: Account?) {
        guard let account = account else {
            let _ = GenericErrorView(displaying: error ?? AmatinoAppError())
            return
        }
        DispatchQueue.main.async { [unowned self] in
            self.progressIndicator.stopAnimation(self)
            self.progressIndicator.isHidden = true
            let deleteView = DeleteAccountControlView(
                frame: NSMakeRect(0, 0, self.frame.width, self.frame.height),
                withTarget: account,
                in: self.tree
            )
            self.addSubview(deleteView)
        }

        return
    }
    
}
