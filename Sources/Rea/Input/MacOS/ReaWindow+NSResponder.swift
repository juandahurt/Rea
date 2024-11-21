//
//  ReaWindow+macOSEvents.swift
//  Rea
//
//  Created by Juan David Hurtado on 19/11/24.
//

#if os(macOS)
import AppKit
import ReaCore

// I know it looks horrible, but I didn't really find a better way to
// observe the events and getting, for example, the mouse location in the
// window... so, yeah
// MARK: - Mouse
extension ReaWindow {
    public override func mouseMoved(with event: NSEvent) {
        let location = event.locationInWindow
        let mappedLocation: Vec2 = [Float(location.x), Float(location.y)]
        input.mouseEventHandler?.mouseMoved(at: mappedLocation)
    }
    
    public override func mouseEntered(with event: NSEvent) {
        
    }
    
    public override func mouseExited(with event: NSEvent) {
        
    }
}

// MARK: - Keyboard
extension ReaWindow {
    public override func keyDown(with event: NSEvent) {
//        Input.instance.notify(event)
    }
}
#endif
