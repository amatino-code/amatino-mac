//
//  CrossFadeSegue.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//


import Foundation
import Cocoa

class CrossFadeSegue: NSStoryboardSegue {

    override func perform() {
        
        let sourceViewController = sourceController as! NSViewController
        let destinationViewController = destinationController as! NSViewController
        let containerViewController = sourceViewController.parent!
        
        containerViewController.insertChildViewController(destinationViewController, at: 1)
        
        containerViewController.view.wantsLayer = true
        sourceViewController.view.wantsLayer = true
        destinationViewController.view.wantsLayer = true
        
        containerViewController.transition(from: sourceViewController, to: destinationViewController, options: .crossfade)
        
    }
    
}
