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

        guard let window = view.window?.windowController as? EntityWindowController else {
            fatalError("Entity window is not of expected type, EntityWindowController")
        }
        
        guard window.entity != nil else { fatalError("Outline view loaded with no entity ready in the window") }
        guard window.session != nil else { fatalError("Outline view loaded with no session ready in the window") }
        
        
        do {
            _ = try Tree(entity: window.entity!, session: window.session!, readyCallback: treeReadyCallback)
        } catch {
            fatalError("Unhandled tree retrieval error: \(error)")
        }

    }
    
    private func treeReadyCallback(_ tree: Tree) {
        return
    }
    
    override func viewWillAppear() {
        progressIndicator.startAnimation(self)
    }

    // _ = performSegue(withIdentifier: successSegueId, sender: self)


}
