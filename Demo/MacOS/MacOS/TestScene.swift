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
    
    override init() {
        super.init()
        player = entityManager.makeEntity()
    }   
    
    override func update(deltaTime: Float) {
        let transform: TransformComponent = player.getComponent()
        transform.position = Vec3(Input.instance.mousePosition, 0)
    }
    
    override func handleInput(event: Event) {
        guard case let .mouse(mouseEvent) = event else {
            return
        }
        if case .mouseMoved = mouseEvent {
            print("mouse moved!")
        }
        
    }
}
