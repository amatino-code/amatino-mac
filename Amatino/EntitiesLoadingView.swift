//
//  EntitiesLoading.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
import AmatinoApi

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
    
    let noEntitiesIdentifier = NSStoryboardSegue.Identifier("entityLoadToNoEntities")
    let someEntitiesIdentifier = NSStoryboardSegue.Identifier("entityLoadToSomeEntities")

    private var session: Session? = nil
    private var user: User? = nil
    private var regionList: RegionList? = nil
    private var entityList: EntityList? = nil
    private var accountingController: AccountingWindowController? = nil
    
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
        
        accountingController = self.view.window?.windowController as? AccountingWindowController
        guard accountingController != nil else { fatalError("AccountingWindowController missing!") }
        
        accountingController?.setEnvironmentCallback(environmentReadyCallback)

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
        
        guard accountingController != nil else { fatalError("AccountingWindowController missing!") }
        
        let list: EntityListAttributes
        do {
            let opList = try accountingController!.entityList?.describe()
            guard opList != nil else { fatalError("Unable to obtain entity list") }
            list = opList!
        } catch {
            fatalError("Unable to obtain entity list")
        }
    
        let actionId: NSStoryboardSegue.Identifier
        if list.entities == nil || list.entities!.count < 1 {
            actionId = noEntitiesIdentifier
        } else {
            actionId = someEntitiesIdentifier
        }
        
        let elapsed = Date().timeIntervalSince(self.start!)
        
        if elapsed < minimumVisibleTime {
            let waitTime = UInt64((self.minimumVisibleTime - elapsed) * Double(NSEC_PER_SEC))
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
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController as? EntityListView {
            guard accountingController != nil else { fatalError("Accounting controller missing!") }
            destination.setEnvironment(accountingController: accountingController!)
            return
        }
    }
    
}
