//
//  Entity.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

public class Entity {
    var id: Int // TODO: maybe have a type alias for this
    
    init(_ id: Int) {
        self.id = id
    }
   
    @MainActor
    public func getComponent<T: Component>(_ type: T.Type) -> T {
        MemoryPool.getComponent(type, ofEntityAt: id)
    }
}
