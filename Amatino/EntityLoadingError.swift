//
//  EntityLoadingError.swift
//  Amatino
//
//  Created by Hugh Jeremy on 29/10/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class EntityLoadingError: NSViewController {
    
    public var errorMessage: String = "Oh no! Something went wrong."
    @IBOutlet weak var errorText: NSTextField!
    
    override func viewWillAppear() {
        errorText.stringValue = errorMessage.replacingOccurrences(
            of: "\n", with: " "
        )
    }

}
