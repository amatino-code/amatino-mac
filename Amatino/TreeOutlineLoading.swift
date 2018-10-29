//
//  Amatino Swift
//  TreeOutlineLoading.swift
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

class TreeOutlineLoadingView: NSViewController {
    
    private let successSegueId = NSStoryboardSegue.Identifier("loadingOutlineToOutline")
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    override func viewDidLoad() {
        view.wantsLayer = true
    }
    
    override func viewDidAppear() {

        guard let window = view.window?.windowController
            as? AccountingWindowController else {
            fatalError("Failed to cast to EntityWindowController")
        }
        
        guard let entity = window.entity else { fatalError(
            "Outline view loaded with no entity ready in the window"
        )}
        guard let session = window.session else { fatalError(
            "Outline view loaded with no session ready in the window"
        )}

        GlobalUnit.retrieve(
            unitId: 5,
            session: session,
            callback: {(error: Error?, unit: GlobalUnit?) in
                if error != nil {
                    fatalError("Unhandled unit retrieval error")
                }
                guard let unit = unit else {
                    fatalError("Inconsistent internal state")
                }
                Tree.retrieve(
                    session: session,
                    entity: entity,
                    globalUnit: unit,
                    callback: self.treeReadyCallback
                )
            }
        )

    }


    private func treeReadyCallback(error: Error?, tree: Tree?) {
        return
    }

    override func viewWillAppear() {
        progressIndicator.startAnimation(self)
    }

    // _ = performSegue(withIdentifier: successSegueId, sender: self)


}
