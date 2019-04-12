//
//  LedgerView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 11/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerView: NSView {
    
    private let defaultFrame = NSMakeRect(0, 0, 761, 475)
    private let loadingView: LedgerLoadingView
    private let idleView: LedgerIdleView
    private let ledgerTableView: LedgerTableView
    private let scrollView: NSScrollView
    private let views: [NSView]
    
    private var ledger: Ledger?
    
    init() {

        ledgerTableView = LedgerTableView(frame: defaultFrame)

        scrollView = NSScrollView(frame: defaultFrame)
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.contentView.documentView = ledgerTableView
        
        loadingView = LedgerLoadingView(frame: defaultFrame)
        idleView = LedgerIdleView(frame: defaultFrame)
        
        views = [loadingView, idleView, scrollView]
    
        super.init(frame: defaultFrame)
        
        addSubview(loadingView)
        addSubview(idleView)
        addSubview(scrollView)
        
        scrollView.frame = bounds
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(
            equalTo: leadingAnchor
        ).isActive = true
        scrollView.trailingAnchor.constraint(
            equalTo: trailingAnchor
        ).isActive = true
        scrollView.topAnchor.constraint(
            equalTo: topAnchor
        ).isActive = true
        scrollView.bottomAnchor.constraint(
            equalTo: bottomAnchor
        ).isActive = true

        //let _ = views.map { self.lockScaling($0) }

        loadingView.isHidden = true
        idleView.isHidden = false
        scrollView.isHidden = true
        
        return
    }
    
    private func hideAll() { let _ = views.map { $0.isHidden = true } }
    public func showLoading() { hideAll(); loadingView.isHidden = false }
    public func showLedger() { hideAll(); scrollView.isHidden = false }
    public func showIdle() { hideAll(); idleView.isHidden = false }
    
    public func present(_ ledger: Ledger) {
        self.ledger = ledger
        ledgerTableView.load(ledger)
        showLedger()
        return
    }
    
    private func lockScaling(_ child: NSView) {
        
        child.translatesAutoresizingMaskIntoConstraints = false

        child.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        ).isActive = true
        child.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        ).isActive = true
        child.topAnchor.constraint(
            equalTo: self.topAnchor
        ).isActive = true
        child.bottomAnchor.constraint(
            equalTo: self.bottomAnchor
        ).isActive = true
        
        return
        
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
