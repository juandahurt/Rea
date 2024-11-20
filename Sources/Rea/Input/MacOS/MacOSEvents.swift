//
//  MacOSEvents.swift
//  Rea
//
//  Created by Juan David Hurtado on 20/11/24.
//

#if os(macOS)
public enum MouseEvent {
    case mouseEntered, mouseExited, mouseMoved
}

public enum KeyEvent {
    case keyDown(Key)
}
#endif
