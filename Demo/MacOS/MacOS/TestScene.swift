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
    
    var scale: Float = 10
    
    var t: Float = 0
    
    override init() {
        super.init()
        player = entityManager.makeEntity()
    }
    
    override func update(deltaTime: Float) {
        let transform: TransformComponent = player.getComponent()
        transform.scale = scale
        
        transform.position = [0, 10 * sin(t), 0]
        
        transform.rotation = t
        
        t += 0.05
    }
}
