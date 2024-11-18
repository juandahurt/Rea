//
//  EntityManager.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

public class EntityManager {
    var entities: [Entity] = []
    var numEntities: UInt8 = 0
    
    public func makeEntity() -> Entity {
        numEntities += 1
        let newEntity = Entity(numEntities)
        entities.append(newEntity)
        return newEntity
    }
}
