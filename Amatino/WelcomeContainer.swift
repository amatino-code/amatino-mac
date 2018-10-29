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

        let boardName = NSStoryboard.Name(rawValue: welcomeBoardName)
        let board = NSStoryboard(name: boardName, bundle: nil)
        let sceneId = NSStoryboard.SceneIdentifier(loginSceneName)
        let welcomeView = board.instantiateController(
            withIdentifier: sceneId
        ) as! NSViewController
        insertChildViewController(welcomeView, at: 0)
        view.addSubview(welcomeView.view)

    }
    
}
