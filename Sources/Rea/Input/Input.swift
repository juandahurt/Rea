//
//  InputSystem.swift
//  Rea
//
//  Created by Juan David Hurtado on 18/11/24.
//

import ReaCore

@MainActor
public class Input {
    weak var eventHandler: InputEventHandler?
    
    private init() {} 
    
    public static let instance = Input() // Not sure about this singleton :/
   
    #if os(macOS)
    public var mousePosition: Vec2 = .zero
    #endif
}

@MainActor
public protocol InputEventHandler: AnyObject {
    func handleInput(event: Event)
}
