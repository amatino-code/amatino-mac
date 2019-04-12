//
//  Amatino Swift
//  TreeOutlineController.swift
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

class TreeOutlineController: NSViewController {
    
    private let defaultTableFrame = NSMakeRect(0, 0, 309, 475)
    
    private var noAccountsInterface: OutlineNoAccounts?
    private var creationInterface: CreateAccountController?
    private var creationPopover: NSPopover?
    private var progressIndicator: NSProgressIndicator?

    public var associatedLedger: LedgerController?
    public var tree: Tree?
    public var unit: GlobalUnit?
    
    private let treeOutline: TreeOutlineView
    
    private var lastPresentedNode: Node? = nil
    
    init(
        outlining tree: Tree,
        denominatedIn unit: GlobalUnit,
        associatedWith ledger: LedgerController? = nil
    ) {
        
        self.tree = tree
        self.unit = unit
        self.associatedLedger = ledger
        self.treeOutline = TreeOutlineView(
            frame: defaultTableFrame,
            outlining: tree
        )
        super.init(nibName: nil, bundle: nil)
        
        return

    }
    
    
    override func viewDidLoad() { treeOutline.sizeToFit() }
    
    required init?(coder: NSCoder) { fatalError("not implemented") }
    
    override func loadView() { view = self.treeOutline }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        let point = treeOutline.convert(event.locationInWindow, from: nil)
        if treeOutline.isMousePoint(point, in: treeOutline.bounds) {
            considerLedgerPresentation(for: treeOutline.selectedNode)
        }
        return
    }
    
    private func considerLedgerPresentation(for node: Node?) {

        guard let ledger = associatedLedger else { return }
        guard let tree = tree else { fatalError("Missing Tree") }
        if node == nil && lastPresentedNode == nil { return }
        lastPresentedNode = node
        guard let node = node else { ledger.showIdle(); return }
        
        ledger.presentLedger(
            forAccount: node,
            in: tree.entity,
            ordered: .oldestFirst
        )
        return

    }
    

// Add AccountPlusButton
    
//    @IBOutlet weak var accountPlus: NSButton!
//    @IBAction func accountPlusClicked(_ sender: Any) {
//        showAccountCreationPopover(anchoredTo: accountPlus)
//        return
//    }
//
//    @IBAction func editAccount(_ sender: NSMenuItem) {
//        print("Edit account")
//        return
//    }

    func deleteAccount() {
        guard let tree = tree else { fatalError("Tree missing!") }
        let row = treeOutline.clickedRow
        guard let node = treeOutline.item(atRow: row) as? Node else {
            fatalError("Unknown item type")
        }
        let deletionController = DeleteAccountController(
            withTarget: node,
            in: tree
        )
        let popover = NSPopover()
        popover.contentViewController = deletionController
        popover.behavior = .transient
        popover.show(
            relativeTo: treeOutline.frame,
            of: treeOutline,
            preferredEdge: .minX
        )

        return
    }
    
    override func viewWillAppear() {

        guard let tree = tree else {
            fatalError("Attempt to load TreeOutline with no loaded Tree")
        }
        
        if tree.accounts.count < 1 {
            let interface = OutlineNoAccounts(
                outline: self.view,
                action: showAccountCreationPopover
            )
            self.view.addSubview(interface)
            noAccountsInterface = interface
        }

        return
    }

    private func refreshTree() {
        let indicator = NSProgressIndicator(frame: self.view.frame)
        indicator.isIndeterminate = true
        indicator.style = .spinning
        self.view.addSubview(indicator)
        indicator.startAnimation(self)
        self.progressIndicator = indicator
        guard let tree = tree else {
            fatalError("Missing Tree!")
        }
        guard let unit = unit else {
            fatalError("Missing unit!")
        }
        Tree.retrieve(
            for: tree.entity,
            denominatedIn: unit,
            then: treeReadyCallback
        )
        return
    }
    
    private func treeReadyCallback(error: Error?, tree: Tree?) {
        guard let tree = tree else {
            let _ = GenericErrorController(
                displaying: error ?? AmatinoAppError(.internalFailure),
                presentedBy: self
            )
            return
        }
        DispatchQueue.main.async { [unowned self] in
            self.reloadTree(tree)
        }
        return
    }
    
    private func reloadTree(_ tree: Tree) {
        self.tree = tree
        progressIndicator?.removeFromSuperview()
        progressIndicator = nil
        if tree.accounts.count > 0 {
            noAccountsInterface?.removeFromSuperview()
            noAccountsInterface = nil
            treeOutline.load(tree)
            return
        }
        self.noAccountsInterface = OutlineNoAccounts(
            outline: self.view,
            action: self.showAccountCreationPopover
        )
        return
    }
    
    private func accountCreationCallback(error: Error?, account: Account?) {
        if let error = error {
            let _ = GenericErrorController(
                displaying: error,
                presentedBy: self
            )
            return
        }
        if let popover = self.creationPopover {
            popover.performClose(self)
        }
        DispatchQueue.main.async {
            self.refreshTree()
        }
        return
    }
    
    private func accountCreationAction(
        arguments: Account.CreateArguments,
        sender: Any?
        ) {
        
        if let popover = creationPopover {
            popover.performClose(self)
        }
        self.creationInterface = nil
        self.creationPopover = nil
        
        guard let entity = tree?.entity else {
            fatalError("Entity is not available")
        }

        Account.create(
            in: entity,
            arguments: arguments,
            then: accountCreationCallback
        )

        return
        
    }
    
    func showAccountCreationPopover(anchoredTo anchor: NSView) {
        guard let tree = tree else { fatalError("Tree missinng") }
        
        let creationInterface = CreateAccountController(
            tree: tree,
            createAction: accountCreationAction
        )
        self.creationInterface = creationInterface
        let popover = NSPopover()
        popover.contentViewController = creationInterface
        popover.behavior = .transient
        popover.show(
            relativeTo: anchor.frame,
            of: anchor,
            preferredEdge: .maxX
        )
        creationPopover = popover
        return
    }

    func showAccountCreationPopover() {
        let anchor: NSView
        if let noAccounts = noAccountsInterface {
            anchor = noAccounts.button
        } else {
            anchor = self.view
        }
        showAccountCreationPopover(anchoredTo: anchor)
        return
    }

}
