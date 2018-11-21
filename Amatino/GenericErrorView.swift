//
//  GenericErrorView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 11/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class GenericErrorView: NSView {
    
    private let rawNetText = """
    Amatino MacOS was unable to communicate with the Amatino API. This is \
    most likely due to a disruption to your internet connection. Amatino MacOS \
    requires an active internet connection to function.
    """
    private let rawGenericText = """
    Amatino encountered an error. Your existing data are safe, but your most \
    recent changes were lost. This may have been caused by a temporary \
    disruption to the Amatino service, or a bug in Amatino's code. If this \
    happens repeatedly, please consider reporting a bug on GitHub.
    """
    private let title = NSLocalizedString(
        "Something went wrong!",
        comment: ""
    )
    private let dismissTitle = NSLocalizedString(
        "Dismiss",
        comment: ""
    )
    
    public let gitButton: GitReportButton
    public let dismissButton: AMButton
    
    private var imageView: NSImageView?
    private let networkImage = NSImage(named: NSImage.networkName)
    private let warningImage = NSImage(named: NSImage.cautionName)
    private let messageView: Label
    private let heading: Label
    
    private let headingFrame = NSMakeRect(90, 169, 276, 19)
    private let startFrame = NSMakeRect(0, 0, 554, 208)
    private let imageFrame = NSMakeRect(20, 96, 59, 59)
    private let textFrame = NSMakeRect(90, 55, 443, 98)
    private let gitButtonFrame = NSMakeRect(309, 13, 144, 32)
    private let dismissButtonFrame = NSMakeRect(454, 13, 87, 32)

    private let error: Error
    
    init(displaying error: Error) {

        if let _ = error as? URLError {
            if let image = networkImage {
                imageView = NSImageView(image: image)
            }
        } else {
            if let image = warningImage {
                imageView = NSImageView(image: image)
            }
        }
        
        let message: String
        if let appError = error as? AmatinoAppError {
            message = NSLocalizedString(appError.message, comment: "")
        } else if let apiError = error as? AmatinoError {
            message = NSLocalizedString(apiError.message, comment: "")
        } else if let _ = error as? URLError {
            message = NSLocalizedString(rawNetText, comment: "")
        } else {
            message = NSLocalizedString(rawGenericText, comment: "")
        }
        messageView = Label(frame: textFrame)
        messageView.stringValue = message
        
        gitButton = GitReportButton(frame: gitButtonFrame)
        dismissButton = AMButton(frame: dismissButtonFrame)
        
        heading = Label(frame: headingFrame)
        heading.stringValue = title
        
        self.error = error

        super.init(frame: startFrame)
    
        dismissButton.isBordered = true
        dismissButton.bezelStyle = .rounded
        dismissButton.setButtonType(.momentaryPushIn)
        dismissButton.title = dismissTitle
        dismissButton.keyEquivalent = "\r"
        
        if let view = imageView {
            view.frame = imageFrame
            addSubview(view)
        }
        addSubview(gitButton)
        addSubview(dismissButton)
        addSubview(messageView)
        addSubview(heading)
        
        return

    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
