//
//  AppDelegate.swift
//  Amatino
//
//  Created by Hugh Jeremy on 10/2/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Cocoa
 

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let welcomeWindowIdentifier = NSStoryboard.SceneIdentifier(
        "welcomeWindowController"
    )
    let accountingWindowIdentifier = NSStoryboard.SceneIdentifier(
        "accountingWindowController"
    )
    let entityWindowIdentifier = NSStoryboard.SceneIdentifier(
        "entityWindowController"
    )
    let welcomeStoryboard = NSStoryboard(
        name: NSStoryboard.Name("Welcome"),
        bundle: nil
    )
    let entitiesStoryboard = NSStoryboard(
        name: NSStoryboard.Name("Entities"),
        bundle: nil
    )
    let accountingStoryboard = NSStoryboard(
        name: NSStoryboard.Name("Accounting"),
        bundle: nil
    )

    var entityListInterface: NSWindowController? = nil
    var welcomeInterface: NSWindowController? = nil
    var login: Login? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        if let login = try? Login() {
            self.login = login
            showEntityListInterface(login: login)
        } else {
            showWelcomeInterface()
        }

    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }

    func showEntityListInterface(login: Login) {
        
        if self.entityListInterface == nil {
            guard let newInterface = entitiesStoryboard.instantiateController(
                withIdentifier: entityWindowIdentifier)
                as? EntityWindowController else {
                    fatalError("Failed to instantiate Entity List window")
            }
            self.entityListInterface = newInterface
        }
        
        guard let interface = self.entityListInterface
            as? EntityWindowController else {
            fatalError("Entity List window missing")
        }
        
        interface.showWindow(self)
        
        if let welcomeInterface = welcomeInterface {
            welcomeInterface.close()
        }

        return
    }

    func showWelcomeInterface() {

        if self.welcomeInterface == nil {
            guard let newInterface = welcomeStoryboard.instantiateController(
                withIdentifier: welcomeWindowIdentifier
                ) as? NSWindowController else {
                    fatalError("Failed to instantiate welcome interface")
            }
            self.welcomeInterface = newInterface
        }
        
        guard let welcomeInterface = self.welcomeInterface else {
            fatalError("Welcome interface missing")
        }

        welcomeInterface.showWindow(self)
        
        if let entityInterface = self.entityListInterface {
            entityInterface.close()
        }

        return
    }
    
    func showAccountingInterface(entity: Entity) {
        guard let accountingInterface =
            accountingStoryboard.instantiateController(
                withIdentifier: entityWindowIdentifier
        ) as? NSWindowController else {
            fatalError("Failed to instantiate entity interface")
        }
        guard let accountingWindow = accountingInterface as?
            AccountingWindowController
            else {
                fatalError("Failed to cast Entity Window")
            }
        guard let session = login?.session else {
            fatalError(
                "Login session not available when loading Entity interface"
            )
        }
        accountingWindow.loadEnvironment(entity, session)
        accountingWindow.window?.title = entity.name
        accountingWindow.showWindow(self)
    }

}

