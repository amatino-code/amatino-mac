//
//  Error.swift
//  Amatino
//
//  Created by Hugh Jeremy on 31/10/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation

public class AmatinoAppError: Error, CustomStringConvertible {
    public let message: String
    public let kind: Kind
    
    public var description: String { get { return self.message} }
    
    public init(_ kind: Kind) {
        self.message = kind.rawValue
        self.kind = kind
        return
    }
    
    public init(_ kind: Kind, _ message: String) {
        self.message = message
        self.kind = kind
        return
    }
    
    public convenience init() {
        self.init(.internalFailure)
        return
    }
    
    public enum Kind: String {
        case internalFailure = """
        Amatino has encountered an internal error. This is most likely
        due to a bug. Please consider reporting this incident on GitHub.
        """
        case inputFailure = """
        Amatino has encountered an error caused by ingestion of unacceptable
        data. This may be caused by a bug or by input data that have violated
        constraints.
        """
    }
}
