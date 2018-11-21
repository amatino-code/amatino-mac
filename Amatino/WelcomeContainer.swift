//
//  WelcomeContainer.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

// http://theiconmaster.com/2015/03/transitioning-between-view-controllers-in-the-same-window-with-swift-mac/

class WelcomeContainer: NSViewController {

    let welcomeBoardName = "Welcome"
    let loginSceneName = "welcomeLogin"
    
    override func viewDidLoad() {

        let boardName = welcomeBoardName
        let board = NSStoryboard(name: boardName, bundle: nil)
        let sceneId = loginSceneName
        let welcomeView = board.instantiateController(
            withIdentifier: sceneId
        ) as! NSViewController
        insertChild(welcomeView, at: 0)
        view.addSubview(welcomeView.view)

    }

}
