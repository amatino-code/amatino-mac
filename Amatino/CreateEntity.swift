//
//  CreateEntity.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//
import Foundation
import Cocoa
 

class CreateEntityPopover: NSViewController {

    @IBOutlet weak var nameInput: NSTextField!
    @IBOutlet weak var descriptionInput: NSTextField!
    @IBOutlet weak var storageRegionMenu: NSPopUpButton!
    
    private var session: Session? = nil
    //private var regions: RegionList? = nil
    private var originator: Any? = nil
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(nil)
    }
    
    @IBAction func createButtonPressed(_ sender: NSButton) {
        
        let arguments: Entity.CreateArguments
        
        do {
            try arguments = Entity.CreateArguments(
                name: nameInput.stringValue,
                description: descriptionInput.stringValue
            )
        } catch {
            fatalError("Unhandled entity creation error")
        }

        if let noEntities = originator as? NoEntitiesView {
            noEntities.createEntity(entityArguments: arguments)
            dismiss(self)
            return
        }
        
        if let _ = originator as? EntityWindowController {
            // Determine whether the request occured with NoEntities
            // or SomeEntities visible, and call the appropriate
            // creation method.
        }

        return
    }
    
    public func loadEnvironment(
        session: Session,
        //regions: RegionList,
        originator: Any
        ) {
        self.session = session
        //self.regions = regions
        self.originator = originator
        return
    }
    
    override func viewDidLoad() {
        installRegions()
    }
    
    private func installRegions() {
        storageRegionMenu.removeAllItems()
        // Add Region listing here
        storageRegionMenu.addItem(withTitle: "Default")
    }
    
}

extension CreateEntityPopover: NSPopoverDelegate {
    
    func popoverShouldClose(_ popover: NSPopover) -> Bool {
        if nameInput.stringValue == "" && descriptionInput.stringValue == "" {
            return true
        }
        return false
    }

}
