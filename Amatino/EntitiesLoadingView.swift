//
//  EntitiesLoading.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

class EntitiesLoadingView: NSViewController {
    
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var determinateProgressIndicator: NSProgressIndicator!
    
    private let progressMax = 100.0
    private let progressMin = 0.0
    
    let minimumVisibleTime = 1.2 // seconds
    private var start: Date? = nil
    private var progressInterval: Double {
        get {
            return (progressMax - progressMin) / (minimumVisibleTime * 60)
        }
    }
    private var progressTimeInterval: Double {
        get {
            return 1 / 60
        }
    }
    
    let noEntitiesIdentifier = "entityLoadToNoEntities"
    let someEntitiesIdentifier = "entityLoadToSomeEntities"
    let noNetIdentifier = "entityLoadToNetWarning"
    let errorIdentifier = "entityLoadToError"

    private var session: Session? = nil
    private var user: User? = nil
    private var regionList: RegionList? = nil
    private var entityList: EntityList? = nil
    private var entityWindowController: EntityWindowController? = nil
    
    private var loadingErrorText = "Oh no! Something went wrong."
    
    override func viewDidLoad() {
        determinateProgressIndicator.maxValue = progressMax
        determinateProgressIndicator.minValue = progressMin
    }
    
    override func viewWillAppear() {
        
        start = Date()
        
        progressIndicator.isHidden = true
        determinateProgressIndicator.doubleValue = progressMin
        
        let _ = Timer.scheduledTimer(
            withTimeInterval: progressTimeInterval,
            repeats: true,
            block: incrementProgress(_:)
        )
        
        progressIndicator.startAnimation(self)

        return
    }
    
    override func viewDidAppear() {
        guard let controller = self.view.window?.windowController as?
            EntityWindowController  else { fatalError(
                "AccountingWindowController missing!"
                ) }
        
        controller.setEnvironmentCallback(environmentReadyCallback)
        controller.setEntitiesLoadingView(self)
        
        guard let login = (NSApplication.shared.delegate as? AppDelegate)?.login
            else {
                fatalError("Login missing from AppDelegate")
        }
    
        controller.loadEnvironment(login: login)
        self.entityWindowController = controller
        
        return
    }
    
    private func incrementProgress(_ timer: Timer) {
        
        determinateProgressIndicator.increment(by: progressInterval)
        
        if Date().timeIntervalSince(self.start!) >= minimumVisibleTime {
            timer.invalidate()
            determinateProgressIndicator.isHidden = true
            progressIndicator.isHidden = false
            progressIndicator.startAnimation(self)
            return
        }
        
        return
    }

    
    private func environmentReadyCallback() {
        
        guard let entityWindowController = entityWindowController else {
            fatalError("entityWindowController missing!")
        }
        
        guard let list = entityWindowController.entityList else {
            fatalError("Entity list missing ")
        }
    
        let actionId: NSStoryboardSegue.Identifier
        if list.entities.count < 1 {
            actionId = noEntitiesIdentifier
        } else {
            actionId = someEntitiesIdentifier
        }
        
        guard let start = self.start else {
            fatalError("start not set")
        }
        
        let elapsed = Date().timeIntervalSince(start)
        
        if elapsed < minimumVisibleTime {
            let waitTime = UInt64(
                (self.minimumVisibleTime - elapsed) * Double(NSEC_PER_SEC)
            )
            let now = DispatchTime.now().uptimeNanoseconds
            let dispatchTime = DispatchTime(uptimeNanoseconds: (waitTime + now))
            DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                self.performSegue(withIdentifier: actionId, sender: nil)
                return
            }
        } else {
            self.performSegue(withIdentifier: actionId, sender: nil)
        }
    }
    
    public func showInternetWarning() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: self.noNetIdentifier, sender: nil)
        }
        return
    }
    
    public func showError(withText text: String) {
        loadingErrorText = text
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: self.errorIdentifier, sender: nil)
        }
        return
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController as? EntityListView {
            guard let entityWindowController = entityWindowController else {
                fatalError("Entity List controller missing!")
            }
            destination.entityWindowController = entityWindowController
            return
        }
        
        if let destination = segue.destinationController
            as? EntityLoadingError {
            destination.errorMessage = loadingErrorText
            return
        }
    }
    
}
