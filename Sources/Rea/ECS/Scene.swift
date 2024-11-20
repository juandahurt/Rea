//
//  Scene.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

@MainActor
open class Scene: InputEventHandler {
    public var entityManager = EntityManager()
    
    public init() {}
    
    open func update(deltaTime: Float) {}
    
    open func handleInput(event: Event) {}
}
