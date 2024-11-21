//
//  TestScene.swift
//  MacOS
//
//  Created by Juan David Hurtado on 15/11/24.
//

import Rea
import ReaCore

class TestScene: Scene {
    var player: Entity!
    
    var mousePos: Vec2 = .zero
    
    override init() {
        super.init()
        player = entityManager.makeEntity()
    }   
    
    override func update(deltaTime: Float) {
        let transform: TransformComponent = player.getComponent()
        transform.position = Vec3(mousePos, 0)
    }
    
    override func mouseMoved(at position: Vec2) {
        mousePos = position
    }
    
    override func mouseDown(at location: Vec2) {
        let newEntity = entityManager.makeEntity()
        let transform: TransformComponent = newEntity.getComponent()
        transform.position = [location.x, location.y, 0]
    }
}
