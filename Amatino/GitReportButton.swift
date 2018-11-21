//
//  GitReportButton.swift
//  Amatino
//
//  Created by Hugh Jeremy on 11/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class GitReportButton: AMButton {
    
    let titleText = NSLocalizedString("Report on Github", comment: "")
    let rawReportUrl = "https://github.com/amatino-code/amatino-mac/issues"
    let reportUrl: URL

    
    override init(frame frameRect: NSRect) {
        guard let url = URL(string: rawReportUrl) else {
            fatalError("Unable to generate reporting URL")
        }
        self.reportUrl = url
        super.init(frame: frameRect)
        self.title = titleText
        self.isBordered = true
        self.bezelStyle = .rounded
        self.setButtonType(.momentaryPushIn)
        return
    }
    
    public func openGitReporting() {
        NSWorkspace.shared.open(reportUrl)
        return
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
