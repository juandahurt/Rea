//
//  Event.swift
//  Rea
//
//  Created by Juan David Hurtado on 19/11/24.
//

public enum Event {
    #if os(macOS)
    case mouse(MouseEvent)
    case key(KeyEvent)
    #endif
}
