//
//  ServerManager.swift
//  MacVaporApp
//
//  Created by Javier Calatrava on 20/06/2026.
//

import Vapor
import Foundation
import Combine

class ServerManager: ObservableObject {
    @Published var isRunning = false
    private var vaporApp: Vapor.Application?
    
    func startServer() {
        guard !isRunning else { return }
        
        Task.detached(priority: .background) {
            do {
                var env = Environment.development
                env.arguments = ["vapor"]
                
                let app = Vapor.Application(env)
                
                app.http.server.configuration.port = 8085
                
                app.get("hello", ":name") { req -> String in
                    guard let name = req.parameters.get("name") else {
                        throw Abort(.badRequest)
                    }
                    return "hello \(name)"
                }
                
                await MainActor.run {
                    self.vaporApp = app
                    self.isRunning = true
                }
                
                try await app.execute()
                
            } catch {
                print("Error en el servidor: \(error)")
                await MainActor.run { self.isRunning = false }
            }
        }
    }
    
    func stopServer() {
        guard isRunning else { return }
        vaporApp?.shutdown()
        self.isRunning = false
        self.vaporApp = nil
    }
}
