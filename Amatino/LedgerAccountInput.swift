//
//  LedgerAccountInput.swift
//  Amatino
//
//  Created by Hugh Jeremy on 23/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerAccountInput: NSView {
    
    private let inputFont = NSFont.systemFont(ofSize: CGFloat(12))

    private var accountSelection: AccountSelection? = nil
    
    public var selectedAccount: AccountRepresentative? {
        get {
            guard let accountSelection = accountSelection else { fatalError("Missing accountSelection") }
            return accountSelection.selectedAccount
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        return
    }
    
    public func offer(
        selection: AccountSelection,
        followedBy nextResponder: NSResponder
    ) {
        
        self.nextResponder = nextResponder
        selection.assignNextResponder(nextResponder)

        if let accountSelection = accountSelection{
            replaceSubview(accountSelection, with: selection)
        } else {
            addSubview(selection)
        }
        
        let leftConstraint = NSLayoutConstraint(
            item: selection,
            attribute: .left,
            relatedBy: .equal,
            toItem: self,
            attribute: .left,
            multiplier: 1,
            constant: 0
        )
        
        let rightConstraint = NSLayoutConstraint(
            item: selection,
            attribute: .right,
            relatedBy: .equal,
            toItem: self,
            attribute: .right,
            multiplier: 1,
            constant: 0
        )
        
        let topConstraint = NSLayoutConstraint(
            item: selection,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        
        let bottomConstraint = NSLayoutConstraint(
            item: selection,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        
        selection.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(topConstraint)
        addConstraint(bottomConstraint)
        addConstraint(leftConstraint)
        addConstraint(rightConstraint)

        //selection.isBordered = false
        //selection.font = inputFont
        self.accountSelection = selection
        return
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
