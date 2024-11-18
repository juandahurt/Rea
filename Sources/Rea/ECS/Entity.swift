//
//  Entity.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

public class Entity {
    var id: UInt8 // TODO: maybe have a type alias for this
    private var components: [Component] = [
        TransformComponent(),
        RenderableComponent()
    ] // TODO: create a memory pool
    
    init(_ id: UInt8) {
        self.id = id
    }
    
    public func getComponent<T: Component>() -> T {
        for c in components {
            if let c = c as? T {
                return c
            }
        }
        fatalError("")
    }
}
