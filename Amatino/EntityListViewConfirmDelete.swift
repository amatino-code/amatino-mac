//
//  EntityListViewConfirmDelete.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa
 

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
        
        guard let deletionTarget = self.deletionTarget else {
            fatalError("Deletion executed without a target")
        }
        view.window?.title = "Confirm Entity Deletion"
        
        showProgress(true)
        
        let warningText = warningBase + deletionTarget.name + "?"
        warning.stringValue = warningText
        
        return
    }
    
    @IBAction func deleteSelected(_ sender: Any) {
        showProgress()
        
        guard let deletionTarget = self.deletionTarget else {
            fatalError("Deletion executed without a target")
        }
        
        deletionTarget.delete(deletionCallback)
    }
    
    private func deletionCallback(error: Error?, entity: Entity?) -> Void {
        guard error == nil else {
            fatalError("Unhandled Entity deletion error")
        }
        guard let listView = self.entityListView else {
            fatalError("Missing entityListView")
        }
        listView.resetDeletionTarget()
        listView.refreshEntityList(self.dismiss)
        return
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
