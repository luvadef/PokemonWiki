//
//  ConnectionManager.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 27-08-22.
//

import Foundation
import Network

class ConnectionManager: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published private(set) var connected: Bool = false

    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.connected = true
            } else {
                self.connected = false
            }
        }
        monitor.start(queue: queue)
    }

    func isConnected(onCompletion: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                onCompletion(true)
                print("CON CONEXION A INTERNET")
            } else {
                onCompletion(false)
                print("SIN CONEXION A INTERNET")
            }
        }
        monitor.start(queue: queue)
    }
}
