//
//  WelcomeSegue.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class WelcomeSegue: NSStoryboardSegue {
    
    var transition: NSViewController.TransitionOptions {
        return .slideForward
    }
    
    override init(
            identifier: NSStoryboardSegue.Identifier,
            source: Any,
            destination: Any
        ) {
        
        super.init(
            identifier: identifier,
            source: source,
            destination: destination
        )
    }
    
    override func perform() {
        
        let sourceViewController = self.sourceController as! NSViewController
        let destinationViewController = self.destinationController as! NSViewController
        let containerViewController = sourceViewController.parent!
        
        containerViewController.insertChildViewController(destinationViewController, at: 1)
        
        sourceViewController.view.wantsLayer = true
        destinationViewController.view.wantsLayer = true
        
        containerViewController.transition(
            from: sourceViewController,
            to: destinationViewController,
            options: transition
        )
        
    }
    
}
