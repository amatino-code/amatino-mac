//
//  WelcomeSegueUp.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class WelcomeSegueUp: WelcomeSegue {
    
    override var transition: NSViewController.TransitionOptions {
        return .slideUp
    }
}


