//
//  CreateEntity.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//
import Foundation
import Cocoa
import AmatinoApi

class CreateEntityPopover: NSViewController {

    @IBOutlet weak var nameInput: NSTextField!
    @IBOutlet weak var descriptionInput: NSTextField!
    @IBOutlet weak var storageRegionMenu: NSPopUpButton!
    
    private var session: Session? = nil
    private var regions: RegionList? = nil
    private var originator: Any? = nil
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(nil)
    }
    
    @IBAction func createButtonPressed(_ sender: NSButton) {
        
        var selectedRegion: Region? = nil
        for region in try! (regions?.describe().allAvailable)! {
            if region.name == storageRegionMenu.titleOfSelectedItem {
                selectedRegion = region
                break
            }
        }
        
        guard selectedRegion != nil else { fatalError("Selected region not fount") }
        
        let arguments: EntityCreateArguments
        
        do {
            try arguments = EntityCreateArguments(
                name: nameInput.stringValue,
                description: descriptionInput.stringValue,
                region: selectedRegion!
            )
        } catch {
            fatalError("Unhandled entity creation error")
        }

        if let noEntities = originator as? NoEntitiesView {
            noEntities.createEntity(entityArguments: arguments)
            dismiss(self)
            return
        }
        
        if let _ = originator as? AccountingWindowController {
            // Determine whether the request occured with NoEntities
            // or SomeEntities visible, and call the appropriate
            // creation method.
        }

        return
    }
    
    public func loadEnvironment(
        session: Session,
        regions: RegionList,
        originator: Any
        ) {
        self.session = session
        self.regions = regions
        self.originator = originator
        return
    }
    
    override func viewDidLoad() {
        installRegions()
    }
    
    private func installRegions() {
        guard regions != nil else { fatalError("Missing regions!") }
        let regionAttributes: RegionListAttributes
        do { regionAttributes = try regions!.describe() }
        catch { fatalError("Unhandled region retrieval error") }
        storageRegionMenu.removeAllItems()
        for entity in regionAttributes.allAvailable {
            storageRegionMenu.addItem(withTitle: entity.name)
        }
        
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
