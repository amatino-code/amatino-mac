//
//  OutlineNoAccountsView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 31/10/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class OutlineNoAccounts: NSView {

    private let resizingMask: NSView.AutoresizingMask = [
        .width, .height
    ]
    private let labelText = NSLocalizedString("No Accounts found", comment: "")
    private let buttonText = NSLocalizedString("New Account", comment: "")
    private let stackSpacing = CGFloat(12)
    public let button: NSButton
    let label: NSTextField
    let stack: NSStackView
    let action: () -> Void

    init(frame frameRect: NSRect, action: @escaping () -> Void) {

        self.action = action
        label = NSTextField(wrappingLabelWithString: labelText)
        button = NSButton(title: buttonText, target: nil, action: nil)
        stack = NSStackView(views: [label, button])
        stack.orientation = .vertical
        stack.spacing = stackSpacing

        super.init(frame: frameRect)
        self.addSubview(self.stack)
        button.target = self
        button.action = #selector(self.buttonPressed)
        
        self.autoresizingMask = resizingMask
        stack.autoresizingMask = resizingMask
        
        return

    }
    
    override func viewWillDraw() {
        let origin = NSMakePoint(
            (NSWidth(bounds) - NSWidth(stack.frame)) / 2,
            (NSHeight(bounds) - NSHeight(stack.frame)) / 2
        )
        
        stack.setFrameOrigin(origin)
    }

    convenience init(outline: NSView, action: @escaping () -> Void) {

        let frame = NSMakeRect(0, 0, outline.frame.width, outline.frame.height)
        self.init(frame: frame, action: action)

        return
    }

    @objc private func buttonPressed() {
        self.action()
        return
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
