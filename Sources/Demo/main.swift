#if canImport(AppKit)
import AppKit
import Rea

class ApplicationDelegate: NSResponder, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let window = ReaWindow(
            contentRect: .init(x: 0, y: 0, width: 800, height: 500),
            styleMask: [.closable, .titled, .resizable],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.makeKeyAndOrderFront(nil)
        window.title = "Rea Engine"
        
        NSApp.setActivationPolicy(.regular)
        NSApp.activate()
    }
}

let delegate = ApplicationDelegate()
let app = NSApplication.shared
app.delegate = delegate
app.run()
#endif
