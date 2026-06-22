//
//  MacVaporAppApp.swift
//  MacVaporApp
//
//  Created by Javier Calatrava on 20/06/2026.
//

import SwiftUI

@main
struct MacVaporAppApp: App {
    @StateObject private var serverManager = ServerManager()
    var body: some Scene {
        WindowGroup {
            ContentView(manager: serverManager)
        }
    }
}
