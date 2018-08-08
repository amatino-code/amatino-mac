//
//  Login.swift
//  Amatino MacOS
//
//  author: hugh@amatino.io
//


import Foundation
 

class Login {
    
    private let apiKeyDefaultsKey = "api_key"
    private let sessionIdDefaultsKey = "session_id"
    private let userIdDefaultsKey = "user_id"

    private let callback: (() -> Void)?
    private let defaults = UserDefaults()
    
    public var session: Session? = nil
    
    init () throws {
        
        callback = nil
        
        let apiKey = defaults.value(forKey: apiKeyDefaultsKey) as? String
        let sessionId = defaults.value(forKey: sessionIdDefaultsKey) as? Int
        let userId = defaults.value(forKey: userIdDefaultsKey) as? Int
        
        if (apiKey == nil || sessionId == nil || userId == nil) {
            removeSession()
            throw SessionError(.notFound)
        }
        
        session = Session(apiKey: apiKey!, sessionId: sessionId!, userId: userId!)

        return
    }
    
    init (email: String, secret: String, callback: @escaping () -> Void ) throws {
        
        self.callback = callback
        
        _ = try Session(email: email, secret: secret, readyCallback: readyCallback)
        return
    }
    
    func readyCallback(_ session: Session) {

        assert(callback != nil)
        self.session = session

        let attributes: SessionAttributes
        do {
            attributes = try session.describe()
        } catch {
            fatalError("Unhandled session retrieval error: \(error)")
        }

        saveSession(attributes: attributes)

        _ = callback!()

        return
        
    }
    
    public func wasSuccessful() -> Bool {
        
        guard session != nil else { fatalError("Inconsistent internal state") }

        do {
            let _ = try session!.describe()
        } catch {
            fatalError("Uncaught session retrieval error: \(error)")
        }
        
        let attributes = try? session!.describe()
        
        
        if attributes == nil {
            return false
        }
        
        return true
    }
    
    public func provideLoginError() -> Error? {
        
        guard session != nil else { fatalError("Inconsistent internal state") }
        
        var errorToReturn: Error? = nil
        
        do {
            let _ = try session!.describe()
        } catch {
            errorToReturn = error
        }

        return errorToReturn
    }
    
    private func saveSession(attributes: SessionAttributes) {
        
        _ = removeSession()
        
        defaults.set(attributes.apiKey, forKey: apiKeyDefaultsKey)
        defaults.set(attributes.sessionId, forKey: sessionIdDefaultsKey)
        defaults.set(attributes.userId, forKey: userIdDefaultsKey)
        
        return
    }
    
    func removeSession() {
        
        defaults.removeObject(forKey: apiKeyDefaultsKey)
        defaults.removeObject(forKey: sessionIdDefaultsKey)
        defaults.removeObject(forKey: userIdDefaultsKey)
        
        return
        
    }
    
}
