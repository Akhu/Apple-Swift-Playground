//
//  ObserverPattern.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 06/10/2021.
//

import SwiftUI
// Code inside modules can be shared between pages and other source files.
import Foundation

struct ObserverPattern: View {
    
    @ObservedObject var dashboard = HomeDashboard()
    var body: some View {
        VStack {
            Button(action: {
                lamp1.toggle()
                print(self.dashboard.statusLamp1)
            }, label: {
                Text("Toogle Lamp")
            })
            
            Text("Lamp is \(dashboard.statusLamp1 ? "On" : "Off")")
            
            
            
        }.onAppear {
            print(self.dashboard.statusLamp1)
        }
    }

}

struct ObserverPattern_Previews: PreviewProvider {
    static var previews: some View {
        ObserverPattern()
    }
}



public var lamp1 = Lamp()

public class HomeDashboard: ObservableObject, Observer {
    public var id: UUID = UUID()

    public func observe(subject: Subject) {
        subject.addObserver(observer: self)
    }

    public func notifiedBySubject(status: Bool) {
        print("Notified ! \(status)")
        self.statusLamp1 = status
    }

    
    @Published public var statusLamp1: Bool = false
    
    public init() {
        self.observe(subject: lamp1)
    }
}

public typealias Observers = [Observer]

public protocol Observer {
    var id:UUID { get set }
    func observe(subject: Subject)
    func notifiedBySubject(status: Bool)
}

public protocol Subject {
    var observerCollection: Observers { get set }
    func notifyObservers()
    func addObserver(observer: Observer)
    func removeObserver(observer: Observer)
}

public class Lamp: Subject {
    
    public init() {}
    
    var isOn = false {
        didSet {
            
            self.notifyObservers()
        }
    }
    
    public func addObserver(observer: Observer) {
        self.observerCollection.append(observer)
    }

    public func removeObserver(observer: Observer) {
        self.observerCollection.removeAll { $0.id == observer.id }
    }


    public var observerCollection: Observers = []

    public func notifyObservers() {
        self.observerCollection.forEach { observer in
            observer.notifiedBySubject(status: self.isOn)
        }
    }

    public func toggle(){
        self.isOn = !self.isOn
    }
}
