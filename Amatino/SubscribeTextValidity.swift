//
//  SubscribeTextValidity.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//

import Foundation

protocol SubscribeValidity {

    var invalidMessage: String { get }
    func isValid() -> Bool
    func showError(message: String) -> Void
    func clearError() -> Void
    
}
