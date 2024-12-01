//
//  EntityManager.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

@MainActor
public class EntityManager {
    var entities: [Entity] = []
    var toBeAdded: [Entity] = []
   
    func makeEntity() -> Entity {
        let id = MemoryPool.makeEntityID()
        let newEntity = Entity(id)
        toBeAdded.append(newEntity)
        return newEntity
    }
    
    func update() {
        entities.append(contentsOf: toBeAdded)
        toBeAdded.removeAll()
    }
    
    // TODO: remove entity
}
