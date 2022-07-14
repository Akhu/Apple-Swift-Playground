//
//  NetworkMonitorView.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 04/07/2021.
//
import Network
import SwiftUI

class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    
    @Published var monitorPublisher: NWPath?
    
    init() {
        monitor
            .pathUpdateHandler = { path in
                DispatchQueue.main.async {
                    self.monitorPublisher = path
                }
            }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}


struct NetworkMonitorView: View {
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        HStack(alignment: .center) {
            VStack{
                Text(networkMonitor.monitorPublisher?.status == .satisfied ? "Network available 👌" : "Network lost ☎️")
            }
        }
    }
}

struct NetworkMonitorView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkMonitorView()
    }
}
