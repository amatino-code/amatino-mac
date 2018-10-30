//
//  EntitiesListView.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

class EntityListView: NSViewController {
    
    private let tableNameCellId = NSUserInterfaceItemIdentifier(
        rawValue: "entityTableCellName"
    )
    private let tableDescriptionCellId = NSUserInterfaceItemIdentifier(
        rawValue: "entityTableCellDescription"
    )
    private let tableOwnerCellId = NSUserInterfaceItemIdentifier(
        rawValue: "entityTableCellOwner"
    )
    private let tableNetAssetsCellId = NSUserInterfaceItemIdentifier(
        rawValue: "entityTableCellNetAssets"
    )
    private let tableNetIncomeCellId = NSUserInterfaceItemIdentifier(
        rawValue: "entityTableCellNetIncome"
    )
    private let deleteConfirmSegueId = NSStoryboardSegue.Identifier(
        "entityListToDeleteConfirm"
    )
    private let noEntitiesSegueId = NSStoryboardSegue.Identifier(
        "entityListToNoEntities"
    )
    
    public var entityWindowController: EntityWindowController? = nil

    private var entityList: EntityList? {
        get {
            return entityWindowController?.entityList
        }
    }
    private var deletionTarget: Entity? = nil
    private var tableReloaded = false

    @IBOutlet weak var entityTableView: NSTableView!
    
    override func viewWillAppear() {
        if let controller = entityWindowController {
            controller.entityListView = self
            if let _ = controller.entityList {
                entityTableView.reloadData()
                tableReloaded = true
            }
        }

        return
    }
    
    override func viewDidAppear() {
        if entityWindowController == nil {
            guard let controller = view.window?.windowController
                as? EntityWindowController else {
                fatalError("Unable to acquire EntityWindowController")
            }
            controller.entityListView = self
            entityWindowController = controller
        }
        if !tableReloaded {
            entityTableView.reloadData()
        }
        tableReloaded = false
        return
    }
    
    public func refreshEntityList(_ completionCallback: @escaping () -> Void) {
        
        guard let entityWindowController = entityWindowController else {
            fatalError("Missing entity Window controller")
        }
        
        entityWindowController.reloadEntityList( {() -> Void in
            
            guard let entityList = self.entityList else {
                fatalError("Missing EntityList")
            }
            
            if entityList.count < 1 {
                self.performSegue(
                    withIdentifier: self.noEntitiesSegueId,
                    sender: nil
                )
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
        
        guard let entityList = entityList else {
            fatalError("Missing EntityList")
        }

        if rowIndex < 0 || rowIndex > entityList.count - 1 {
            return
        }

        let target = entityList[rowIndex]
        
        deletionTarget = target
        
        performSegue(withIdentifier: deleteConfirmSegueId, sender: nil)
        return
    }

    @IBAction func openEntitySelected(_ sender: NSMenuItem) {
        let rowIndex = entityTableView.selectedRow
        
        guard let entityList = entityList else {
            fatalError("Missing EntityList")
        }

        if rowIndex < 0  || rowIndex > (entityList.count - 1) {
            return
        }
        
        let target = entityList[rowIndex]

        openEntity(target)
        return
    }

    public func resetDeletionTarget() {
        deletionTarget = nil
        return
    }
    
    public func reloadEntityTable() {
        entityTableView.reloadData()
        return
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let destination = segue.destinationController
                as? EntityListViewConfirmDelete {
            guard deletionTarget != nil else {
                fatalError("Deletion target not set")
            }
            destination.setDeletionTarget(
                targetEntity: deletionTarget!,
                entityView: self
            )
        }
        return
    }
    
    private func openEntity(_ entity: Entity) {
        let app = NSApplication.shared.delegate as! AppDelegate
        app.showAccountingInterface(entity: entity)
        return
    }
    
}

extension EntityListView: NSTableViewDelegate {

    func tableView(
        _ tableView: NSTableView,
        viewFor tableColumn: NSTableColumn?,
        row: Int
    ) -> NSView? {
        if tableColumn == nil {
            return nil
        }
        
        guard let entityList = entityList else {
            return nil
        }
        
        guard entityList.count > 0 else {
            return nil
        }
        
        guard row < entityList.count else {
            return nil
        }
        
        let entity = entityList[row]
        let result: NSTableCellView
        
        switch tableColumn!.title {
        case "Name":
            result = tableView.makeView(
                withIdentifier: tableNameCellId,
                owner: self
            ) as! NSTableCellView
            result.textField!.stringValue = entity.name
            return result
        case "Description":
            result = tableView.makeView(
                withIdentifier: tableDescriptionCellId,
                owner: self
            ) as! NSTableCellView
            result.textField!.stringValue = entity.description ?? ""
            return result
        case "Owner":
            result = tableView.makeView(
                withIdentifier: tableOwnerCellId,
                owner: self
            ) as! NSTableCellView
            result.textField!.stringValue = String(describing: entity.ownerId)
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
        return entityList?.count ?? 0
    }
    
}
