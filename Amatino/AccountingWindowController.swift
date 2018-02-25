//
//  AccountingWindowController.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//


import Foundation
import Cocoa
import AmatinoApi

class AccountingWindowController: NSWindowController {
    
    public private(set) var login: Login? = nil
    public private(set) var session: Session? = nil
    public private(set) var user: User? = nil
    public private(set) var regionList: RegionList? = nil
    public private(set) var entityList: EntityList? = nil
    
    @IBOutlet weak var toolbarEmailField: NSTextField!

    public var environmentReady: Bool {
        get {
            if user != nil && regionList != nil && entityList != nil {
                return true
            }
            return false
        }
    }
    private var environmentReadyCallback: (() -> Void)? = nil
    
    func loadEnvironment(login: Login) {

        self.login = login
        session = login.session
        
        do {
            let _ = try EntityList(session: session!, readyCallback: entitiesReadyCallback, listType: .active)
        } catch {
            fatalError("Unhandled entity list retrieval error: \(error)")
        }
        
        do {
            let _ = try RegionList(session: session!, readyCallback: regionsReadyCallback)
        } catch {
            fatalError("Unhandled region retrieval error: \(error)")
        }
        
        do {
            let _ = try session!.retrieveUser(readyCallback: userReadyCallback)
        } catch {
            fatalError("Unhandled user retrieval error: \(error)")
        }
        
    }
    
    private func userReadyCallback(_ user: User) {
        do { try _ = user.describe() }
        catch { fatalError("Unhandled user retrieval error: \(error)") }
        self.user = user
        toolbarEmailField.stringValue = try! user.describe().email
        overallCompletionCallback()
        return
    }
    
    private func regionsReadyCallback(_ regions: RegionList) {
        do { try _ = regions.describe() }
        catch { fatalError("Unhandled region retrieval error: \(error)")}
        regionList = regions
        overallCompletionCallback()
        return
    }
    
    private func entitiesReadyCallback(_ entities: EntityList) {
        do { try _ = entities.describe()}
        catch { fatalError("Unhandled entity retrieval error: \(error)")}
        entityList = entities
        overallCompletionCallback()
        return
    }
    
    private func overallCompletionCallback() {
        
        guard entityList != nil else { return }
        guard regionList != nil else { return }
        guard user != nil else { return }
        
        if environmentReadyCallback != nil {
            environmentReadyCallback!()
        }
        
        return
    }
    
    public func setEnvironmentCallback(_ callback: @escaping () -> Void) {
        
        environmentReadyCallback = callback
        
        if environmentReady == true {
            environmentReadyCallback!()
        }
        
        return
    }
    
    public func reloadEntityList(_ callback: @escaping () -> Void) {
        
        do {
            let _ = try EntityList(session: session!, readyCallback: { (_ entities: EntityList) in
                self.entityList = entities
                callback()
                return
            }, listType: .active)
        } catch {
            fatalError("Unhandled entity list retrieval error: \(error)")
        }
    }

    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController as? CreateEntityPopover {
            guard environmentReady == true else { fatalError("Attempt create entity before environment ready") }
            destination.loadEnvironment(session: session!, regions: regionList!, originator: self)
            return
        }
    }
    
}
