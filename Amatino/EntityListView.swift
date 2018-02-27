//
//  EntitiesListView.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
import AmatinoApi

class EntityListView: NSViewController {
    
    private let tableNameCellId = NSUserInterfaceItemIdentifier(rawValue: "entityTableCellName")
    private let tableDescriptionCellId = NSUserInterfaceItemIdentifier(rawValue: "entityTableCellDescription")
    private let tableOwnerCellId = NSUserInterfaceItemIdentifier(rawValue: "entityTableCellOwner")
    private let tableNetAssetsCellId = NSUserInterfaceItemIdentifier(rawValue: "entityTableCellNetAssets")
    private let tableNetIncomeCellId = NSUserInterfaceItemIdentifier(rawValue: "entityTableCellNetIncome")
    
    private let deleteConfirmSegueId = NSStoryboardSegue.Identifier("entityListToDeleteConfirm")
    private let noEntitiesSegueId = NSStoryboardSegue.Identifier("entityListToNoEntities")
    
    private var accountingController: AccountingWindowController? = nil
    private var entityListAttributes: EntityListAttributes? = nil
    private var deletionTarget: Entity? = nil

    @IBOutlet weak var entityTableView: NSTableView!
    
    public func setEnvironment(accountingController: AccountingWindowController) {
        self.accountingController = accountingController
        do {
            try entityListAttributes = accountingController.entityList?.describe()
        } catch {
            fatalError("Unhandled entity listing error")
        }
        guard entityListAttributes != nil else { fatalError("Missing entity list") }
    }
    
    public func refreshEntityList(_ completionCallback: @escaping () -> Void) {
        accountingController?.reloadEntityList( {() -> Void in
            self.setEnvironment(accountingController: self.accountingController!)

            guard self.accountingController!.entityList != nil else {
                fatalError("Entity list missing after refresh")
            }
            let numberOfEntities: Int?
            do {
                try numberOfEntities = self.accountingController!.entityList!.describe().entities?.count
            }
            catch {
                fatalError("Unhandled entity retrieval error: \(error)")
            }
            
            if numberOfEntities == nil || numberOfEntities! < 1 {
                self.performSegue(withIdentifier: self.noEntitiesSegueId, sender: nil)
                completionCallback()
                return
            }
            
            self.entityTableView.reloadData()
            completionCallback()
            return
        })
    }
    
    @IBAction func deleteEntitySelected(_ sender: Any) {
        let rowIndex = entityTableView.selectedRow
        if rowIndex < 0  || rowIndex > (entityListAttributes!.entities!.count - 1) {
            return
        }
        
        let target = entityListAttributes!.entities![rowIndex]
        
        deletionTarget = target
        
        performSegue(withIdentifier: deleteConfirmSegueId, sender: nil)
        return
    }

    @IBAction func openEntitySelected(_ sender: NSMenuItem) {
        let rowIndex = entityTableView.selectedRow
        if rowIndex < 0  || rowIndex > (entityListAttributes!.entities!.count - 1) {
            return
        }
        
        let target = entityListAttributes!.entities![rowIndex]
        openEntity(target)
        return
    }

    public func resetDeletionTarget() {
        deletionTarget = nil
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController as? EntityListViewConfirmDelete {
            guard deletionTarget != nil else { fatalError("Deletion target not set") }
            destination.setDeletionTarget(
                targetEntity: deletionTarget!,
                entityView: self
            )
        }
        return
    }
    
    private func openEntity(_ entity: Entity) {
        let app = NSApplication.shared.delegate as! AppDelegate
        app.showEntityInterface(entity: entity)
        return
    }
    
}

extension EntityListView: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if tableColumn == nil {
            return nil
        }
        
        if entityListAttributes!.entities == nil {
            return nil
        }
        
        if row > entityListAttributes!.entities!.count {
            return nil
        }
        
        guard let attributes = try? entityListAttributes!.entities![row].describe() else {
            return nil
        }
        
        let result: NSTableCellView
        
        switch tableColumn!.title {
        case "Name":
            result = tableView.makeView(withIdentifier: tableNameCellId, owner: self) as! NSTableCellView
            result.textField!.stringValue = attributes.name
            return result
        case "Description":
            result = tableView.makeView(withIdentifier: tableDescriptionCellId, owner: self) as! NSTableCellView
            result.textField!.stringValue = attributes.description
            return result
        case "Owner":
            result = tableView.makeView(withIdentifier: tableOwnerCellId, owner: self) as! NSTableCellView
            result.textField!.stringValue = String(describing: attributes.owner)
            return result
        case "Net Assets":
            return nil
        case "Net Income (12mo)":
            return nil
        default:
            return nil
        }
    }
}

extension EntityListView: NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        if entityListAttributes!.entities == nil {
            return 0
        }
        return entityListAttributes!.entities!.count
    }
    
}
