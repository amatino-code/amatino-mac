//
//  LedgerController.swift
//  Amatino
//
//  Created by Hugh Jeremy on 11/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerController: NSViewController {
    
    // The primary encapsulating NSView of the ledger
    let ledgerView: LedgerView
    
    // Child view controllers providing discrete ledger GUI elements
    private let ledgerTableController: LedgerTableController
    
    private weak var outlineController: TreeOutlineController? = nil
    
    private static let relevantNotifications = [
        Notification.Name.TRANSACTION_DID_CREATE
    ]
    
    init() {
        ledgerView = LedgerView()
        ledgerTableController = LedgerTableController()

        super.init(nibName: nil, bundle: nil)

        addChild(ledgerTableController)
        ledgerView.addSubview(ledgerTableController.view)

        let center = NotificationCenter.default
        let _ = LedgerController.relevantNotifications.map { (name) in
            center.addObserver(
                forName: name,
                object: nil,
                queue: nil,
                using: receive
            )
        }
        return
    }
    
    override func loadView() {
        self.view = ledgerView
        return
    }
    
    required init?(coder: NSCoder) { fatalError("not implemented") }
    
    public func register(controller: TreeOutlineController) {
        self.outlineController = controller
        return
    }
    
    public func presentLedger(
        forAccount account: AccountRepresentative,
        in entity: Entity,
        ordered order: LedgerOrder,
        withAccountsFrom tree: Tree
    ) {
        
        ledgerView.showLoading()
        Ledger.retrieve(
            for: account,
            in: entity,
            inOrder: order,
            then: { (error: Error?, ledger: Ledger?) in
                DispatchQueue.main.async {
                    guard let ledger = ledger else {
                        let _ = GenericErrorController(
                            displaying: error,
                            presentedBy: self
                        )
                        return
                    }
                    self.ledgerView.present(ledger, withAccountsFrom: tree)
                    return
                }
            }
        )
    }

    public func showIdle() { ledgerView.showIdle() }
    
    private func receive(_ notification: Notification) {
        let object = notification.object
        switch notification.name {
        case Notification.Name.TRANSACTION_DID_CREATE:
            guard let transaction = object as? Transaction else { return }
            considerEffectOf(newTransaction: transaction)
        default:
            return
        }
    }
    
    private func considerEffectOf(newTransaction transaction: Transaction) {
        guard let anchorAccount = ledgerView.ledger?.account else { return }
        guard transaction.doesTouch(account: anchorAccount) else { return }
        guard let existingLedger = ledgerView.ledger else { return }
        existingLedger.refresh { (error, ledger) in
            DispatchQueue.main.async {
                guard let ledger = ledger else {
                    let _ = GenericErrorController.init(
                        displaying: error,
                        presentedBy: self
                    )
                    return
                }
                self.ledgerView.refresh(ledger)
                return
            }
        }
        return
    }

}
