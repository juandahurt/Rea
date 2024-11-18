//
//  TestScene.swift
//  MacOS
//
//  Created by Juan David Hurtado on 15/11/24.
//

import Rea

class TestScene: Scene {
    var player: Entity!
    
    override init() {
        super.init()
        player = entityManager.makeEntity()
    }
    
    override func update() {
        let transform: TransformComponent = player.getComponent()
        transform.position.x += 0.09
    }
}
