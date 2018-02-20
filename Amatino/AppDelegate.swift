//
//  AppDelegate.swift
//  Amatino
//
//  Created by Hugh Jeremy on 10/2/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Cocoa
import AmatinoApi

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let welcomeWindowIdentifier = NSStoryboard.SceneIdentifier("welcomeWindowController")
    let accountingWindowIdentifier = NSStoryboard.SceneIdentifier("accountingWindowController")
    let welcomeStoryboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    let accountingStoryboard = NSStoryboard(name: NSStoryboard.Name("Accounting"), bundle: nil)
    
    var accountingInterface: NSWindowController? = nil
    var welcomeInterface: NSWindowController? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // debug logout
        let debugLogin = try? Login()
        debugLogin?.removeSession()
        
        let login = try? Login()
        
        if login == nil {
            showWelcomeInterface()
        } else {
            showAccountingInterface()
        }

    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }
    
    func showAccountingInterface() {
        accountingInterface = accountingStoryboard.instantiateController(withIdentifier: accountingWindowIdentifier) as? NSWindowController
        guard accountingInterface != nil else { fatalError("Failed to instantiate accounting interface") }
        accountingInterface?.showWindow(self)
        welcomeInterface?.close()
        return
    }

    func showWelcomeInterface() {
        welcomeInterface = welcomeStoryboard.instantiateController(withIdentifier: welcomeWindowIdentifier) as? NSWindowController
        guard welcomeInterface != nil else { fatalError("Failed to instantiate welcome interface") }
        welcomeInterface?.showWindow(self)
        return
    }

}

