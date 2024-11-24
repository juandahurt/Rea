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
    open func mouseMoved(at location: Vec2) {}
    
    @objc
    open func mouseDown(at location: Vec2) {}
}


extension Scene: KeyEventHandler {
    @objc
    open func keyDown(_ key: Key) {}
    
    @objc
    open func keyUp(_ key: Key) {}
}
