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

    
    private let progressIndicator: NSProgressIndicator
    private let progressIndicatorFrame = NSMakeRect(24, 24, 32, 32)
    
    init() {

        progressIndicator = NSProgressIndicator(
            frame: progressIndicatorFrame
        )
        super.init(frame: DeleteAccountView.defaultFrame)
        progressIndicator.style = .spinning
        progressIndicator.isIndeterminate = true
        progressIndicator.controlSize = .small
        addSubview(progressIndicator)
        return
    }
    
    public func showProgress() {
        progressIndicator.isHidden = false
        progressIndicator.startAnimation(self)
        return
    }
    
    public func stopShowingProgress() {
        self.progressIndicator.stopAnimation(self)
        self.progressIndicator.isHidden = true
        return
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
