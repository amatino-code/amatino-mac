//
//  TreeUnit.swift
//  Amatino
//
//  Created by Hugh Jeremy on 31/10/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation

class TreeUnit {
    
    private let cacheKey = "am-tree-outline-unit"
    private let isGlobalUnitKey = "is-global-unit"
    private let unitIdKey = "unit-id"
    private let fallbackGlobalUnitId = 5 // USD

    let store = NSUbiquitousKeyValueStore.default
    let cacheData: [String : Any]?
    let entity: Entity
    
    init(entity: Entity) {
        cacheData = store.dictionary(forKey: cacheKey)
        
        self.entity = entity
        return
    }
    
    func retrieve(callback: @escaping (Error?, GlobalUnit?) -> Void) {
        if let cacheData = cacheData {
            retrieveCached(cacheData, callback)
            return
        }
        GlobalUnit.retrieve(
            unitId: fallbackGlobalUnitId,
            session: entity.session,
            callback: callback
        )
        return
    }
    
    func storeDefault(globalUnit: GlobalUnit) {
        let newData: [String : Any?] = [
            isGlobalUnitKey: true,
            unitIdKey: globalUnit.id
        ]
        store.set(newData, forKey: cacheKey)
        return
    }

    private func retrieveCached(
        _ cacheData: [String : Any],
        _ callback: @escaping (Error?, GlobalUnit?) -> Void
        ) {
        guard let isGlobalUnit = cacheData[isGlobalUnitKey] as? Bool else {
            callback(AmatinoAppError(.internalFailure), nil); return
        }
        guard let unitId = cacheData[unitIdKey] as? Int else {
            callback(AmatinoAppError(.internalFailure), nil); return
        }
        if isGlobalUnit {
            GlobalUnit.retrieve(
                unitId: unitId,
                session: entity.session,
                callback: callback
            )
            return
        }
        fatalError("Custom unit defaults not implemented")
        //CustomUnit.retrieve(
        //    unitId: unitId,
        //    entity: self.entity
        //    callback: callback
        //)
        //return
    }
}



