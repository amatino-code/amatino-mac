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
    private let defaults = UserDefaults()
    
    public var session: Session? = nil
    
    init () throws {
        
        let apiKey = defaults.value(forKey: apiKeyDefaultsKey) as? String
        let sessionId = defaults.value(forKey: sessionIdDefaultsKey) as? Int
        let userId = defaults.value(forKey: userIdDefaultsKey) as? Int
        
        if (apiKey == nil || sessionId == nil || userId == nil) {
            removeSession()
            throw SessionError(.notFound)
        }
        
        session = Session(
            apiKey: apiKey!,
            sessionId: sessionId!,
            userId: userId!
        )

        return
    }
    
    init (
        email: String,
        secret: String,
        callback: @escaping (Error?) -> Void
    ) {
        
        _ = Session.create(
            email: email,
            secret: secret,
            then: { (error, session) in
                guard error == nil else {
                    callback(error)
                    return
                }
                guard let session = session else {
                    callback(error ?? AmatinoError(.inconsistentState))
                    return
                }
                self.session = session
                self.saveSession(session)
                callback(nil)
                return
            }
        )
        return
    }
    
    private func saveSession(_ session:  Session) {
        
        _ = removeSession()
        
        defaults.set(session.apiKey, forKey: apiKeyDefaultsKey)
        defaults.set(session.sessionId, forKey: sessionIdDefaultsKey)
        defaults.set(session.userId, forKey: userIdDefaultsKey)
        
        return
    }
    
    func removeSession() {
        
        defaults.removeObject(forKey: apiKeyDefaultsKey)
        defaults.removeObject(forKey: sessionIdDefaultsKey)
        defaults.removeObject(forKey: userIdDefaultsKey)
        
        return
        
    }
    
}
