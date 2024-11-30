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
//    var numEntities: UInt8 = 0
   
    func makeEntity() -> Entity {
        print("creating entity")
        let id = MemoryPool.makeEntityID()
        let newEntity = Entity(id)
        toBeAdded.append(newEntity)
        debugPrint(newEntity)
        print("appending entity")
        return newEntity
    }
    
    func update() {
        entities.append(contentsOf: toBeAdded)
        toBeAdded.removeAll()
    }
    
    // TODO: remove entity
}
