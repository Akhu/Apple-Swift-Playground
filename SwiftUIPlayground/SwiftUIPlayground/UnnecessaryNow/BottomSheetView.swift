//
//  BottomSheetView.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 21/06/2021.
//

import SwiftUI
import MapKit

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
}

struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.secondary)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
        )
    }

    @GestureState private var translation: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring(), value: isOpen)
            .animation(.interactiveSpring(), value: translation)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}

struct BottomSheetViewSample: View {
    @State var isOpen: Bool = false
    @Namespace private var animation
    
    @GestureState private var translation: CGFloat = 0
    let maxHeight: CGFloat = 450
    
    var minHeight: CGFloat = 100
    
    @State var openSheet: Bool = false
    
    @State private var dragAmount = CGSize.zero
    
    @State var selectedItem:AnnotationItem? = nil
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    var body: some View {
        
            VStack {
                MapKitWithLocation(annotationsItems: annotationItemsFromRawRegion, selectedItem: $selectedItem)
                    .clipShape(RoundedRectangle(cornerRadius: isOpen ? 20 : 10, style: .continuous))
                    .matchedGeometryEffect(id: "map", in: animation)
                    .animation(.spring())
                    .padding(isOpen ? 14 : 8)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0.0, y: 5.0)
                
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Circle()
                            .frame(width: isOpen ? 50 : 30)
                        Text(isOpen ?  "Headline" : "Select a point on map")
                            .font(.headline)
                    }
                    if isOpen {
                        HStack(alignment: .center) {
                            Image("image-3")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                            VStack {
                                HStack {
                                    Text(selectedItem?.id ?? "Missing data")
                                        .font(.headline)
                                    Image(systemName: "mappin.and.ellipse")
                                }
                                HStack {
                                    Text("Information 2")
                                        .font(.headline)
                                }
                            }
                        }.transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    }
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight:  isOpen ? 450 : 100, alignment: .leading)
                .background(Color.blue.edgesIgnoringSafeArea(.all))
                .clipShape(RoundedRectangle(cornerRadius: isOpen ? 10 : 20, style: .continuous))

            }
            .onChange(of: selectedItem, perform: { value in
                self.isOpen = (value != nil)
            })
            .edgesIgnoringSafeArea(.bottom)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        
    }
}

struct BottomSheetViewSample_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetViewSample()
    }
}
