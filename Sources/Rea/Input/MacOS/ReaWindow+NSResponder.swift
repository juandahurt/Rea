//
//  ReaWindow+macOSEvents.swift
//  Rea
//
//  Created by Juan David Hurtado on 19/11/24.
//

#if os(macOS)
import AppKit

// I know it looks horrible, but I didn't really find a better way to
// observe the events and getting, for example, the mouse location in the
// window... so, yeah
// MARK: - Mouse
extension ReaWindow {
    public override func mouseMoved(with event: NSEvent) {
        Input.instance.notify(event)
    }
    
    public override func mouseEntered(with event: NSEvent) {
        Input.instance.notify(event)
    }
    
    public override func mouseExited(with event: NSEvent) {
        Input.instance.notify(event)
    }
}

// MARK: - Keyboard
extension ReaWindow {
    public override func keyDown(with event: NSEvent) {
        Input.instance.notify(event)
    }
}
#endif
