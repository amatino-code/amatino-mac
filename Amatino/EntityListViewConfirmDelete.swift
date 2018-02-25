//
//  EntityListViewConfirmDelete.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
import AmatinoApi

class EntityListViewConfirmDelete: NSViewController {
    
    let warningBase = "Are you sure you want to delete "
    
    var deletionTarget: Entity? = nil
    var entityListView: EntityListView? = nil

    @IBOutlet weak var warning: NSTextField!
    @IBOutlet weak var cancelButton: NSButton!
    @IBOutlet weak var deleteButton: NSButton!
    @IBOutlet weak var progressSpinner: NSProgressIndicator!
    @IBOutlet weak var deletionText: NSTextField!
    
    override func viewWillAppear() {
        
        guard deletionTarget != nil else { fatalError("Deletion executed without a target") }
        view.window?.title = "Confirm Entity Deletion"
        
        showProgress(true)
        
        do {
            let attributes = try deletionTarget!.describe()
            let warningText = warningBase + attributes.name + "?"
            warning.stringValue = warningText
        } catch {
            fatalError("Unhandled entity description error: \(error)")
        }
        
        return
    }
    
    @IBAction func deleteSelected(_ sender: Any) {
        showProgress()
        do {
            try deletionTarget!.delete(readyCallback: { (entity: Entity) -> Void in
                self.entityListView!.resetDeletionTarget()
                self.entityListView!.refreshEntityList(self.dismiss)
            })
        } catch {
            fatalError("Unhandled entity deletion errors: \(error)")
        }
    }
    
    private func dismiss() {
        dismiss(self)
    }
    
    private func showProgress(_ reverse: Bool = false) {
        warning.isHidden = !reverse
        cancelButton.isHidden = !reverse
        deleteButton.isHidden = !reverse
        progressSpinner.isHidden = reverse
        deletionText.isHidden = reverse
        if reverse == true {
            progressSpinner.stopAnimation(nil)
        } else {
            progressSpinner.startAnimation(nil)
        }
    }
    
    @IBAction func cancelSelected(_ sender: Any) {
        dismiss(self)
        return
    }

    public func setDeletionTarget(targetEntity: Entity, entityView: EntityListView) {
        deletionTarget = targetEntity
        entityListView = entityView
        return
    }
    
}
