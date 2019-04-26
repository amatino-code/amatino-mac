//
//  TransactionEditorController.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TransactionEditorController: NSViewController {
    
    let editor = TransactionEditor()
    
    private var editedTransaction: Transaction? = nil
    
    convenience init(editing transaction: Transaction) {
        self.init()
        self.editedTransaction = transaction
        return
    }
    
    convenience init(editingTransactionWithId id: Int, in entity: Entity) {
        self.init()
        editor.showLoadingIndication()
        Transaction.retrieve(
            from: entity,
            withId: id,
            then: loadTransaction
        )
        return
    }
    
    private func loadTransaction(_ error: Error?, _ transaction: Transaction?) {
        DispatchQueue.main.async {
            guard let transaction = transaction else {
                let _ = GenericErrorController.init(
                    displaying: error,
                    displayIn: NSApplication.shared.keyWindow
                )
                self.dismiss(nil)
                return
            }
            self.editor.load(transaction)
            return
        }
    }
}
