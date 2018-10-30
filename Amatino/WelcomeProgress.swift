//
//  WelcomeProgress.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//
import Foundation
import Cocoa

class WelcomeProgress: NSViewController {
    
    private let minimumVisibleTime: Double = 1 // seconds
    private let reversalSegueId = NSStoryboardSegue.Identifier("progressReversalSegue")
    private let successSegueId = NSStoryboardSegue.Identifier("welcomeSuccessSegue")
    
    @IBOutlet weak var welcomeProgress: NSProgressIndicator!
    private var request: SubscriptionRequest? = nil
    private var start: Date? = nil
    
    override func viewDidLoad() {
        
        welcomeProgress.startAnimation(self)
        start = Date()
        
    }
    
    func installRequest(_ request: SubscriptionRequest) {
        self.request = request
        let alreadyFinished = request.setCallback(processResponse)
        if alreadyFinished == true { processResponse() }
        return
    }
    
    
    func processResponse() -> Void {
        
        DispatchQueue.main.async(execute: {() -> Void in
            assert(self.request != nil)
            assert(self.start != nil)
            
            let responseCode = (self.request?.response as? HTTPURLResponse)?.statusCode
            
            let action: () -> Void
            
            let elapsed = Date().timeIntervalSince(self.start!)
            
            if self.request?.error != nil || responseCode != 200 {
                action = self.reverseSegue
            } else {
                action = self.proceedSegue
            }
            
            if elapsed < self.minimumVisibleTime {
                let waitTime = UInt64((self.minimumVisibleTime - elapsed) *
                    Double(NSEC_PER_SEC))
                let now = DispatchTime.now().uptimeNanoseconds
                let dispatchTime = DispatchTime(
                    uptimeNanoseconds: (waitTime + now)
                )
                DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                    action()
                    return
                }
            } else {
                action()
                return
            }
        })
    }
    
    func reverseSegue() {
        _ = performSegue(withIdentifier: reversalSegueId, sender: nil)
    }
    
    func proceedSegue() {
        _ = performSegue(withIdentifier: successSegueId, sender: nil)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController as? WelcomeCreateAccount {
            guard request != nil else { fatalError("Unexpectedly nil request") }
            destination.populateFields(attributes: request!.attributes)
        }
        
        if let destination = segue.destinationController as? WelcomeConfirmAccount {
            guard request != nil else { fatalError("Unexpectedly nil request") }
            destination.setCustomerEmail(email: request!.email)
        }
    }

}
