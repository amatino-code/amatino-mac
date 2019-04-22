//
//  AccountSelectionTextField.swift
//  Amatino
//
//  Created by Hugh Jeremy on 21/4/19.
//  Copyright © 2019 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa


class AccountSelectionTextField: NSTextField, NSTextFieldDelegate {
    
    let items: Array<AccountSelection.Item>
    
    private var isAutocompleting = false
    private var lastAutocompletion = ""
    
    private var changeCallback: ((AccountSelection.Item) -> Void)? = nil
    
    public var selectedItem: AccountSelection.Item? {
        get {
            for item in items {
                if item.hierarchyName == stringValue { return item }
            }
            return nil
        }
    }


    init(
        offering items: Array<AccountSelection.Item>,
        in frame: NSRect
    ) {
        self.items = items
        super.init(frame: frame)
        delegate = self
        isAutomaticTextCompletionEnabled = true
        importsGraphics = false
        isSelectable = true
        isEditable = true
        drawsBackground = false
        focusRingType = .exterior
        isBordered = false
        isBezeled = false
        cell?.lineBreakMode = .byTruncatingMiddle
        lineBreakMode = .byTruncatingMiddle
        return
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        if stringValue.isEmpty { return }
        if let textEditor = currentEditor() {
            textEditor.selectAll(self)
            return
        }
        return
    }
    
    override func keyUp(with event: NSEvent) {
        super.keyUp(with: event)
        let code = event.keyCode
        if keyCodesToIgnore.contains(code) { return }
        if stringValue.isEmpty { return }
        autoComplete()

        return
    }
    
    override func textDidEndEditing(_ notification: Notification) {
        guard let selectedItem = self.selectedItem else {
            
            guard stringValue != "" else { return }
            let tentativeName = String(
                stringValue.split(separator: ":").last ?? ""
            )
            guard let superView = superview as? AccountSelection else {
                fatalError("Unexpected superview type")
            }
            superView.createAccount(tentativelyNamed: tentativeName)
            //window?.makeFirstResponder(self)
            return
        }
        changeCallback?(selectedItem)
        window?.makeFirstResponder(nextResponder)
        return
    }
    
    override func textDidChange(_ notification: Notification) {
        if isAutocompleting {
            print("We are autocompleting and text just changed.")
        }
        return
    }
    
    private func autoComplete() {
        guard !isAutocompleting else { return }
        guard lastAutocompletion != stringValue else { return }
        isAutocompleting = true
        currentEditor()?.complete(nil)
        isAutocompleting = false
        lastAutocompletion = stringValue
        return
    }
    
    func control(
        _ control: NSControl,
        textView: NSTextView,
        completions words: [String],
        forPartialWordRange charRange: NSRange,
        indexOfSelectedItem index: UnsafeMutablePointer<Int>
    ) -> [String] {

        let input = textView.string
        let startIndex = input.startIndex
        let endIndex = input.index(startIndex, offsetBy: charRange.upperBound)
        let searchTerm = String(input[startIndex..<endIndex])
        let candidates = lookForItems(startingWith: searchTerm)
        let completions = candidates.map( { $0.hierarchyName } )
        
        return completions
    }

    private func lookForItems(
        startingWith string: String
    ) -> Array<AccountSelection.Item> {
        
        let input = string.lowercased()
        var candidates = Array<AccountSelection.Item>()
        for item in items {
            if item.hierarchyName.lowercased().hasPrefix(input) { candidates.append(item)
            }
        }
        return candidates
    }
    
    public func registerCallbackOnChange(
        _ callback: @escaping (AccountSelection.Item) -> Void
    ) {
        changeCallback = callback
        return
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum Key: UInt16 {
        case backspace = 51
        case spacebar = 49
        case tab = 48
        case colon = 41
        case enter = 36
    }
    
    private let keyCodesToIgnore = [
        Key.backspace.rawValue,
        Key.spacebar.rawValue
    ]

}
