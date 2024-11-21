//
//  Scene.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

import Foundation
import ReaCore

@MainActor
open class Scene {
    public var entityManager = EntityManager()
    
    public init() {}
    
    open func update(deltaTime: Float) {}
}

extension Scene: MouseEventHandler {
    @objc
    open func mouseMoved(at position: Vec2) {
        
    }
}
