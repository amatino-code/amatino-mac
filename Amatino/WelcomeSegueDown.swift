//
//  WelcomeSegueDown.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class WelcomeSegueDown: WelcomeSegue {
    
    override var transition: NSViewController.TransitionOptions {
        return .slideDown
    }
}


