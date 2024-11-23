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
    
    var velocity: Vec3 = .zero
    
    var velocityUp = Vec3(0, 1, 0)
    var velocityDown = Vec3(0, -1, 0)
    var velocityLeft = Vec3(-1, 0, 0)
    var velocityRight = Vec3(1 , 0, 0)
    
    enum Dir { case up, down, left, right }
    var dirs: [Dir: Bool] = [
        .up: false,
        .down: false,
        .left: false,
        .right: false
    ]
    
    override init() {
        super.init()
        player = entityManager.makeEntity()
    }
    
    override func update(deltaTime: Float) {
        let transform: TransformComponent = player.getComponent()
        transform.scale = scale
        
        transform.rotation = t
        
        t += 0.01
        
        applyVelocity()
    }
    
    override func keyDown(_ key: Key) {
        if key.code == .w {
            dirs[.up] = true
        }
        if key.code == .a {
            dirs[.left] = true
        }
        if key.code == .s {
            dirs[.down] = true
        }
        if key.code == .d {
            dirs[.right] = true
        }
    }
    
    override func keyUp(_ key: Key) {
        if key.code == .w {
            dirs[.up] = false
        }
        if key.code == .a {
            dirs[.left] = false
        }
        if key.code == .s {
            dirs[.down] = false
        }
        if key.code == .d {
            dirs[.right] = false
        }
    }
}


extension TestScene {
    func applyVelocity() {
        let transfom: TransformComponent = player.getComponent()
        for (key, value) in dirs {
            if key == .up && value {
                transfom.position += velocityUp
            }
            if key == .down && value {
                transfom.position += velocityDown
            }
            if key == .left && value {
                transfom.position += velocityLeft
            }
            if key == .right && value {
                transfom.position += velocityRight
            }
        }
    }
}
