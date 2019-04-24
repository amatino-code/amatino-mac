//
//  OpposingAccount.swift
//  Amatino
//
//  Created by Hugh Jeremy on 12/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerTableAccountView: NSView {
    
    private let text = NSTextField()
    
    private let row: LedgerRow

    private var selection: AccountSelection
    private var trackingArea: NSTrackingArea?
    private var selectionViewConstraints: Array<NSLayoutConstraint>? = nil

    init (
        for row: LedgerRow,
        frame frameRect: NSRect,
        selection: AccountSelection
    ) {
        self.selection = selection
        self.row = row
        super.init(frame: frameRect)
        text.frame = bounds
        text.stringValue = row.opposingAccountName
        text.isBordered = false
        text.drawsBackground = false
        text.font = LedgerTableView.font
        addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        establishSelectionConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
        selection.translatesAutoresizingMaskIntoConstraints = false
        return
    }
    
    override func mouseEntered(with event: NSEvent) {
        text.isHidden = true
        selection.configureForDisplayInTable()
        selection.isEnabled = true
        addSubview(selection)
        constrainSelectionView()
        if let accountId = row.opposingAccountId {
            selection.selectAccount(withId: accountId)
        } // Else we have a split transaction
        super.mouseEntered(with: event)
    }
    
    override func mouseExited(with event: NSEvent) {
        text.isHidden = false
        releaseSelectionView()
        selection.removeFromSuperview()
        super.mouseExited(with: event)
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if let existingArea = trackingArea {
            removeTrackingArea(existingArea)
            trackingArea = nil
            return
        }
        let newArea = NSTrackingArea(
            rect: self.bounds,
            options: [.mouseEnteredAndExited, .activeInKeyWindow],
            owner: self,
            userInfo: nil
        )
        trackingArea = newArea
        addTrackingArea(newArea)
        return
    }
    
    private func establishSelectionConstraints() {

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
        
        selectionViewConstraints = [
            leftConstraint,
            rightConstraint,
            topConstraint,
            bottomConstraint
        ]
        return
    }
    
    private func constrainSelectionView() {
        guard let constraints = selectionViewConstraints else {
            fatalError("Constraints not established")
        }
        for constraint in constraints { constraint.isActive = true }
        return
    }
    
    private func releaseSelectionView() {
        guard let constraints = selectionViewConstraints else {
            fatalError("Constraints not established")
        }
        for constraint in constraints { constraint.isActive = false }
        return
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
