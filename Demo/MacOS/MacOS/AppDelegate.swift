//
//  AppDelegate.swift
//  MacOS
//
//  Created by Juan David Hurtado on 15/11/24.
//

import Cocoa
import Rea

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let window = ReaWindow(
            contentRect: .init(x: 0, y: 0, width: 800, height: 500),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )
        
        window.scene = TestScene()
        
        window.center()
        window.title = "Rea Engine"
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

