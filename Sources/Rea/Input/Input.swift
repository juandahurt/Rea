//
//  InputSystem.swift
//  Rea
//
//  Created by Juan David Hurtado on 18/11/24.
//

import ReaCore

@MainActor
public class Input {
    #if os(macOS)
    var mouseEventHandler: MouseEventHandler?
    var keyEventHandler: KeyEventHandler?
    #endif
    
    init() {}
}
