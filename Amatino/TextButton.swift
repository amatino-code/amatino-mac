//
//  TextButton.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation
import Cocoa

@IBDesignable
class TextButton: NSButton {
    
    @IBInspectable var standardColor: NSColor?
    @IBInspectable var highlightColor: NSColor?
    
    override func awakeFromNib() {

        guard standardColor != nil else { return }
        guard font != nil else {return}
        
        let styleAttributes = [
            NSAttributedStringKey.foregroundColor: standardColor!,
            NSAttributedStringKey.font: font!,
            NSAttributedStringKey.paragraphStyle: generateStyle()
        ] as [NSAttributedStringKey : Any]
        
        let attributedTitle = NSAttributedString(string: title, attributes: styleAttributes)
        self.attributedTitle = attributedTitle
        
    }
    
    func showStandardState() {
        guard standardColor != nil else { return }
        self.attributedTitle = generateTitle(color: standardColor!)
    }
    
    func showHighlightState() {
        guard highlightColor != nil else { return }
        self.attributedTitle = generateTitle(color: highlightColor!)
    }
    
    private func generateTitle(color: NSColor) -> NSAttributedString {
        return NSAttributedString(string: title, attributes: generateAttributes(color: color))
    }
    
    private func generateStyle() -> NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return style
    }
    
    private func generateAttributes(color: NSColor) -> [NSAttributedStringKey: Any] {
        let attributes = [
            NSAttributedStringKey.foregroundColor: color,
            NSAttributedStringKey.font: font!,
            NSAttributedStringKey.paragraphStyle: generateStyle()
        ] as [NSAttributedStringKey: Any]
        return attributes
    }

}
