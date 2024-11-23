//
//  KeyEventHandler.swift
//  Rea
//
//  Created by Juan David Hurtado on 22/11/24.
//

@MainActor
public protocol KeyEventHandler {
    func keyDown(_ key: Key)
    func keyUp(_ key: Key)
}
