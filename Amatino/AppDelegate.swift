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
    let entityWindowIdentifier = NSStoryboard.SceneIdentifier("entityWindowController")
    let welcomeStoryboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    let accountingStoryboard = NSStoryboard(name: NSStoryboard.Name("Accounting"), bundle: nil)
    let entityStoryboard = NSStoryboard(name: NSStoryboard.Name("Entity"), bundle: nil)

    var accountingInterface: NSWindowController? = nil
    var welcomeInterface: NSWindowController? = nil
    var login: Login? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        login = try? Login()

        if login == nil {
            showWelcomeInterface()
        } else {
            showAccountingInterface(login!)
        }

    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }

    func showAccountingInterface(_ login: Login) {
        accountingInterface = accountingStoryboard.instantiateController(withIdentifier: accountingWindowIdentifier) as? NSWindowController
        guard accountingInterface != nil else { fatalError("Failed to instantiate accounting interface") }
        let accountingWindow = accountingInterface as? AccountingWindowController
        guard accountingWindow != nil else { fatalError("Failed to cast Accounting Window") }
        accountingWindow?.loadEnvironment(login: login)
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
    
    func showEntityInterface(entity: Entity) {
        let entityInterface = entityStoryboard.instantiateController(withIdentifier: entityWindowIdentifier) as? NSWindowController
        guard entityInterface != nil else { fatalError("Failed to instantiate entity interface") }
        let entityWindow = entityInterface as? EntityWindowController
        guard entityWindow != nil else { fatalError("Failed to cast Entity Window") }
        entityWindow?.loadEntity(entity)
        let name: String
        do {
            name = try entity.describe().name
        } catch {
            fatalError("Unhandled entity retrieval error")
        }
        entityWindow?.window?.title = name
        entityWindow?.showWindow(self)
    }

}

