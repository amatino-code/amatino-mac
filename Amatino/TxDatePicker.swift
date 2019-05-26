//
//  TxDatePicker.swift
//  Amatino
//
//  Created by Hugh Jeremy on 26/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class TxEditorDatePicker: NSDatePicker {
    
    public static let marginRight = CGFloat(10)
    public static let marginBottom = CGFloat(10)
    
    let defaultFrame = NSRect(x: 20, y: 217, width: 217, height: 20)
    
    var topConstraint: NSLayoutConstraint?
    var leftConstraint: NSLayoutConstraint?
    
    init() {
        super.init(frame: defaultFrame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidMoveToSuperview() {
        guard let superview = superview else {
            topConstraint?.isActive = false
            leftConstraint?.isActive = false
            topConstraint = nil
            leftConstraint = nil
            return
        }
        // Constraints to TransactionEditor margins are only rational if..
        guard let _ = superview as? TransactionEditor else { return }
        let leftConstraint = NSLayoutConstraint(
            item: self,
            attribute: .left,
            relatedBy: .equal,
            toItem: superview,
            attribute: .left,
            multiplier: 1,
            constant: TransactionEditor.marginLeft
        )
        leftConstraint.isActive = true
        self.leftConstraint = leftConstraint
        let topConstraint = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: superview,
            attribute: .top,
            multiplier: 1,
            constant: TransactionEditor.marginTop
        )
        topConstraint.isActive = true
        self.topConstraint = topConstraint
        return
    }

    required init?(coder: NSCoder) { fatalError("Not implemented") }

}
