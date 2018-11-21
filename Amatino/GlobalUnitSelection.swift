//
//  GlobalUnitSelection.swift
//  Amatino
//
//  Created by Hugh Jeremy on 4/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class GlobalUnitSelection: AMPopUpButton {
    
    private let session: Session
    private let doesPullDown = false
    private let fallbackUnitCode = "USD"
    private var list: GlobalUnitList?

    public var readyCallback: (() -> Void)?

    init(frame frameRect: NSRect, session: Session) {
        self.session = session
        super.init(frame: frameRect, pullsDown: doesPullDown)
        retrieveList()
        return
    }
    
    convenience init(
        frame frameRect: NSRect,
        session: Session,
        readyCallback: @escaping () -> Void
    ) {
        self.init(frame: frameRect, session: session)
        self.readyCallback = readyCallback
        return
    }
    
    private func retrieveList() {
        removeAllItems()
        addItem(withTitle: "Loading...")
        isEnabled = false
        GlobalUnitList.retrieve(session: session, callback: unitListCallback)
        return
    }

    private func unitListCallback(error: Error?, list: GlobalUnitList?) {
        guard let list = list else { fatalError("Unhandled retrieval error") }
        DispatchQueue.main.async {
            self.loadUnitList(list: list)
        }
        return
    }
    
    private func loadUnitList(list: GlobalUnitList) {
        self.removeAllItems()
        self.list = list
        let _ = list.map {
            self.addItem(withTitle: self.formTitle(unit: $0)) }
        isEnabled = true
        let localeCode = Locale.current.currencyCode ?? fallbackUnitCode
        guard let localUnit = list.unitWith(code: localeCode) ?? list.unitWith(
            code: fallbackUnitCode
            ) else {
                fatalError("Fallback unit code does not exist")
        }
        self.selectItem(withTitle: self.formTitle(unit: localUnit))
        guard let callback = readyCallback else {
            return
        }
        callback()
        return
    }
    
    private func formTitle(unit: GlobalUnit) -> String {
        let code = NSLocalizedString(unit.code, comment: "")
        let name = NSLocalizedString(unit.name, comment: "")
        return code + " - " + name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init from coder not implemented")
    }
    
    public func retrieveSelectedUnit() throws -> GlobalUnit {
        let code = String(selectedItem!.title.prefix(3))
        guard let list = list else {
            throw(AmatinoAppError(.internalFailure))
        }
        guard let unit = list.unitWith(code: code) else {
            throw(AmatinoAppError(.internalFailure))
        }
        return unit
    }
}
