//
//  EntityManager.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

public class EntityManager {
    var numEntities: UInt8 = 0
    
    public func makeEntity() -> Entity {
        return Entity(numEntities)
        numEntities += 1
    }
}
