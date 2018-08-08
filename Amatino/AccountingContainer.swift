//
//  AccountingContainer.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

class AccountingContainer: NSViewController {
    
    let board = NSStoryboard(name: NSStoryboard.Name(rawValue: "Accounting"), bundle: nil)
    let entityLoadScene = NSStoryboard.SceneIdentifier("entityLoadView")

    public var session: Session? = nil
    
    override func viewDidLoad() {

        session = (NSApplication.shared.delegate as? AppDelegate)?.login?.session
        
        guard session != nil else { fatalError("Accounting view initialised without a session") }

        let accountingView = board.instantiateController(withIdentifier: entityLoadScene) as! NSViewController
        accountingView.view.wantsLayer = true
        insertChildViewController(accountingView, at: 0)
        view.addSubview(accountingView.view)

    }
    
}
