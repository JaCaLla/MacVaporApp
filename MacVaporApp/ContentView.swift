//
//  ContentView.swift
//  MacVaporApp
//
//  Created by Javier Calatrava on 20/06/2026.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager: ServerManager
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Circle()
                    .fill(manager.isRunning ? Color.green : Color.red)
                    .frame(width: 14, height: 14)
                
                Text(manager.isRunning ? "REST Server Active" : "REST Server Offline")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            
            if manager.isRunning {
                Text("Listening on: http://localhost:8085/hello/{name}")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 20) {
                Button(action: { manager.startServer() }) {
                    Text("Start Server")
                        .padding(.horizontal, 10)
                }
                .disabled(manager.isRunning)
                .keyboardShortcut("s", modifiers: .command)
                
                Button(action: { manager.stopServer() }) {
                    Text("Stop Server")
                        .padding(.horizontal, 10)
                }
                .disabled(!manager.isRunning)
                .keyboardShortcut("d", modifiers: .command)
            }
        }
        .frame(width: 450, height: 220)
        .padding()
    }
}
