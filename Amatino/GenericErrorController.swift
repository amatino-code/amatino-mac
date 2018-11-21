//
//  GenericErrorController.swift
//  Amatino
//
//  Created by Hugh Jeremy on 11/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class GenericErrorController: NSViewController {
    
    private let error: Error
    private var errorView: GenericErrorView?
    
    unowned let controller: NSViewController
    
    init(displaying error: Error, presentedBy controller: NSViewController) {
        self.error = error
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
        controller.presentAsSheet(self)
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let loadedView = GenericErrorView(displaying: error)
        loadedView.gitButton.action = #selector(self.closeWithGit)
        loadedView.dismissButton.action = #selector(self.closeWithoutGit)
        errorView = loadedView
        self.view = loadedView
        return
    }
    
    @objc
    func closeWithoutGit() {
        controller.dismiss(self)
        return
    }
    
    @objc
    func closeWithGit() {
        self.errorView?.gitButton.openGitReporting()
        controller.dismiss(self)
        return
    }

}
