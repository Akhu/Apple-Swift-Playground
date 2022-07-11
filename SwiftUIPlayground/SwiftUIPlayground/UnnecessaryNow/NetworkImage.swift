//
//  AsyncImage.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 25/06/2021.
//
import Foundation
import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}


final class Loader: ObservableObject {
    
    var task: URLSessionDataTask!
    @Published var loadStatus:String = "no"
    @Published var data: Data? = nil
    
    init(urlRequest: URLRequest){
        task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data,urlResponse,error in
            DispatchQueue.main.async {
                self.data = data
            }
            
            if(self.data != nil) {
                DispatchQueue.main.async {
                    self.loadStatus = "loaded"
                }
            }
        })
        task.resume()
    }
    
    init(_ url: URL) {
        task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            DispatchQueue.main.async {
                self.data = data
            }
        })
        task.resume()
    }
    deinit {
        task.cancel()
    }
}

let placeholder = UIImage(named: "placeholder")!

public struct AsyncImage: View {
    var isCenterCropped = false
    var isResizable = false
    @ObservedObject private var imageLoader: Loader
    
    public init(url: URL, centerCropped: Bool = false, resizable: Bool = false) {
        self.isCenterCropped = centerCropped
        self.isResizable = resizable
        self.imageLoader = Loader(url)
    }
    
    public init(urlRequest: URLRequest){
        self.imageLoader = Loader(urlRequest: urlRequest)
    }
    
    var image: UIImage? {
        return imageLoader.data.flatMap(UIImage.init)
    }
    @ViewBuilder
    public var body: some View {
        if isCenterCropped && isResizable {
            Image(uiImage: image ?? placeholder)
                .resizable()
                .centerCropped()
                .redacted(reason: image != nil ? [] : .placeholder)
        }
        
        if isCenterCropped {
            Image(uiImage: image ?? placeholder)
                .centerCropped()
                .redacted(reason: image != nil ? [] : .placeholder)
        }
        
        if isResizable {
            Image(uiImage: image ?? placeholder)
                .resizable()
                .redacted(reason: image != nil ? [] : .placeholder)
        }
        
        
        if !isResizable && !isCenterCropped {
            Image(uiImage: image ?? placeholder)
                .redacted(reason: image != nil ? [] : .placeholder)
        }
        
    }
}
