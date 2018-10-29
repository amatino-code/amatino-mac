//
//  EntityWindowController.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//


import Foundation
import Cocoa

class EntityWindowController: NSWindowController {
    
    let connectionFailures = [-1003, -1009]
    
    let offlineWarningId = NSStoryboard.SceneIdentifier("offlineWarning")
    
    public private(set) var login: Login? = nil
    public private(set) var session: Session? = nil
    public private(set) var user: User? = nil
    public private(set) var regionList: RegionList? = nil
    public private(set) var entityList: EntityList? = nil
    public private(set) var entitiesLoadingView: EntitiesLoadingView? = nil
    
    @IBOutlet weak var toolbarEmailField: NSTextField!

    public var environmentReady: Bool {
        get {
            if entityList != nil { //&& user != nil && regionList != nil {
                return true
            }
            return false
        }
    }
    private var environmentReadyCallback: (() -> Void)? = nil
    
    func loadEnvironment(login: Login) {

        self.login = login
        guard let session = login.session else {
            fatalError("Supplied Login has no Session")
        }
        self.session = session
        retrieveEntityList(overallCompletionCallback)
        
        return
    }
    
    private func retrieveEntityList(
        _ completionCallback: @escaping () -> Void
    ) {
        
        guard let session = login?.session else {
            fatalError("Session missing")
        }

        func entityCallback(error: Error?, list: EntityList?) -> Void {
            guard let loadingView = entitiesLoadingView else {
                fatalError("EntitiesLoadingView is missing")
            }
            guard let list = list else {
                if let code = (error as? URLError)?.errorCode {
                    if connectionFailures.contains(code) {
                        loadingView.showInternetWarning()
                        return
                    }
                }
                if let amatinoError = error as? AmatinoError {
                    switch amatinoError.kind {
                    case .notAuthenticated:
                        divertToWelcomeInterface()
                    default:
                        loadingView.showError(withText: amatinoError.message)
                    }
                    return
                }
                fatalError("Uncaught list retrieval error")
            }
            entityList = list
            DispatchQueue.main.async {
                completionCallback()
            }
            return
        }
        
        EntityList.retrieve(
            session: session,
            scope: .active,
            callback: entityCallback
        )
        
        // Lookup user and region list
        
        return
    }
    
    private func divertToWelcomeInterface() {
        guard let app = NSApplication.shared.delegate as?
            AppDelegate else {
                fatalError("Failed to acquire AppDelegate")
        }
        DispatchQueue.main.async {
            app.showWelcomeInterface()
        }
        return
    }

    
    private func overallCompletionCallback() {
        
        guard entityList != nil else { return }
        //guard regionList != nil else { return }
        //guard user != nil else { return }
        
        guard let callback = environmentReadyCallback else {
            fatalError("Environment ready callback not set")
        }
        
        DispatchQueue.main.async {
            callback()
        }

        return
    }
    
    public func setEnvironmentCallback(_ callback: @escaping () -> Void) {
        
        environmentReadyCallback = callback
        
        if environmentReady == true {
            DispatchQueue.main.async {
                callback()
            }
        }
        
        return
    }
    
    public func setEntitiesLoadingView(_ view: EntitiesLoadingView) {
        entitiesLoadingView = view
        return
    }
    
    public func reloadEntityList(_ callback: @escaping () -> Void) {
        retrieveEntityList(callback)
        return
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController
                as? CreateEntityPopover {
            guard environmentReady == true else {
                fatalError("Attempt create entity before environment ready")
            }
            guard let session = session else { fatalError("Missing session") }
            destination.loadEnvironment(
                session: session,
                //regions: regions,
                originator: self
            )
            return
        }
        
        if let destination = segue.destinationController as? EntityListView {
            destination.reloadEntityTable()
            return
        }
    }
    
    
}
