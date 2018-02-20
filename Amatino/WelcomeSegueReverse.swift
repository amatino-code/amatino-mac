//
//  WelcomeSegueReverse.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class WelcomeSegueReverse: WelcomeSegue {
    
    override var transition: NSViewController.TransitionOptions {
        return .slideBackward
    }
}


