//
//  MainMenu.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 07/06/2022.
//

import SwiftUI

enum MenuCategory: String, Hashable, CaseIterable {
    case animation,uiSamples, data, device, location, permissions, notifications

    var toHeaderSection: String {
        switch self {
            
        case .animation:
            return "✨ Animations"
        case .location:
            return "📍 Location and Map"
        case .permissions:
            return "🔐 Permissions management"
        case .notifications:
            return "🔔 Notifications"
        case .uiSamples:
            return "🎚️ User Interface - Views"
        case .data:
            return "💾 Data, Network and Quality"
        case .device:
            return "📱 Device and Sensors"
        }
    }
}

struct ViewItem {
    let label: String
    let view: AnyView
    var isNew = false
    let category: MenuCategory
}

enum ViewsIndex: CaseIterable {
    case snowFall, drawingsParticles, swiftData, hackerNewsSample, dynamicTypeSize, babyGradientAndShadows, multiDatePicker, shareLink, gridView, bottomSheet, sizeClass, haptic, permissions, localNotifications, scrollViewFixedElement, lazyGridViewWithImages, gradientOnImage, animation, mapKit, mapKitLocation, networkMonitor, timerWithProgressBars, observerPattern
    
    var category: MenuCategory {
        switch self {
        case .snowFall:
            return .animation
        case .drawingsParticles:
            return .animation
        case .swiftData:
            return .data
        case .hackerNewsSample:
            return .data
        case .dynamicTypeSize:
            return .uiSamples
        case .babyGradientAndShadows:
            return .uiSamples
        case .multiDatePicker:
            return .uiSamples
        case .shareLink:
            return .uiSamples
        case .gridView:
            return .uiSamples
        case .bottomSheet:
            return .uiSamples
        case .sizeClass:
            return .uiSamples
        case .haptic:
            return .device
        case .permissions:
            return .permissions
        case .localNotifications:
            return .notifications
        case .scrollViewFixedElement:
            return .uiSamples
        case .lazyGridViewWithImages:
            return .uiSamples
        case .gradientOnImage:
            return .uiSamples
        case .animation:
            return .animation
        case .mapKit:
            return .location
        case .mapKitLocation:
            return .location
        case .networkMonitor:
            return .data
        case .timerWithProgressBars:
            return .uiSamples
        case .observerPattern:
            return .data
        }
    }
    
    func viewForCase() -> ViewItem {
        switch self {
        case .snowFall:
            return ViewItem(label: "Snow Fall Particles", view: AnyView(MetaBallFallView()), isNew: true, category: .animation)
        case .drawingsParticles:
            return ViewItem(label: "Drawings & Particles", view: AnyView(DrawingsView()), isNew: true, category: .animation)
        case .swiftData:
            return ViewItem(label: "SwiftData", view: AnyView(SwiftDataContentView()),  isNew: true, category: .data)
        case .hackerNewsSample:
            return ViewItem(label: "Hacker News API Consumer", view: AnyView(LastHackerNewsView()), category: .data)
        case .dynamicTypeSize:
            return ViewItem(label: "Dynamic Type Size Layout", view: AnyView(DynamicTypeSizeView()), isNew: true, category: .uiSamples)
        case .babyGradientAndShadows:
            return ViewItem(label: "Gradient and Shadows", view: AnyView(BabyLevelGradient()), isNew: true, category: .uiSamples)
//        case .searchableScope:
//            return ViewItem(label: "Searchable Scope", view: AnyView(SearchableScopeView()), isNew: true)
        case .multiDatePicker:
            return ViewItem(label: "Multi Date Picker", view: AnyView(MultiDatePickerView()), isNew: true, category: .uiSamples)
        case .shareLink:
            return ViewItem(label: "Share Link", view: AnyView(ShareLinkView()), isNew: true, category: .uiSamples)
        case .gridView:
            return ViewItem(label: "GridView", view: AnyView(GridView()), isNew: true, category: .uiSamples)
        case .timerWithProgressBars:
            return ViewItem(label: "Progress Bars with Timer", view: AnyView(ProgressBarsView()),category: .uiSamples)
        case .bottomSheet:
            return ViewItem(label: "Bottom Sheet", view: AnyView(iOS16BottomSheet()), isNew: true, category: .uiSamples)
        case .sizeClass:
            return ViewItem(label: "Size Class Sample", view: AnyView(SizeClassView()), category: .uiSamples)
        case .haptic:
            return ViewItem(label: "Haptic Playground", view: AnyView(Haptic()), category: .device)
        case .permissions:
            return ViewItem(label: "Permission Combine", view: AnyView(PermissionsWithCombine()), category: .permissions)
        case .localNotifications:
            return ViewItem(label: "Local Notifications", view: AnyView(LocalNotificationView()), category: .notifications)
        case .scrollViewFixedElement:
            return ViewItem(label: "Scroll View Fixed element", view: AnyView(ScrollViewFixedElement()), category: .uiSamples)
        case .lazyGridViewWithImages:
            return ViewItem(label: "Lazy Grid View With Images", view: AnyView(LazyGridView()), category: .uiSamples)
        case .gradientOnImage:
            return ViewItem(label: "Gradient on Image", view: AnyView(GradientOnImage()), category: .uiSamples)
        case .animation:
            return ViewItem(label: "Animation", view: AnyView(AnimationPlayground()), category: .animation)
        case .mapKit:
            return ViewItem(label: "MapKit", view: AnyView(MapView()), category: .location)
        case .mapKitLocation:
            return ViewItem(label: "MapKit with Location", view: AnyView(MapKitWithLocation(annotationsItems: annotationItemsFromRawRegion, selectedItem: .constant(nil))), category: .location)
        case .networkMonitor:
            return ViewItem(label: "Dynamic Network monitoring", view: AnyView(NetworkMonitorView()), category: .data)
        case .observerPattern:
            return ViewItem(label: "Observer Pattern", view: AnyView(ObserverPattern()), category: .data)
        }
    }
    
}

struct MainMenu: View {
    @State private var presentedView:[ViewsIndex] = []
    @State private var selectedItem: ViewsIndex?
    
    var buildMenu: [String: [ViewsIndex]] {
        var finalArray = [String: [ViewsIndex]]()
        MenuCategory.allCases.forEach { category in
            finalArray[category.rawValue] = ViewsIndex.allCases.filter({ $0.category == category})
        }
        return finalArray
    }
    
    var body: some View {
        NavigationStack(path: $presentedView) {
            VStack {
                List {
                    ForEach(MenuCategory.allCases, id: \.self) { element in
                        Section(element.toHeaderSection) {
                            ForEach(buildMenu[element.rawValue]!, id: \.hashValue) { viewIndex in
                                let viewItem = viewIndex.viewForCase()
                                NavigationLink(value: viewIndex) {
                                    HStack {
                                        if viewItem.isNew {
                                            Text("🆕")
                                        }
                                        Text(viewItem.label)
                                    }
                                }.id(viewIndex)
                            }
                        }
                    }
                }
                .navigationDestination(for: ViewsIndex.self) { item in
                    item.viewForCase().view
                }
                .navigationTitle(Text("🛝 Swift Playground"))
                .toolbar {
                    ToolbarItem {
                        Button {
                            presentedView = [ViewsIndex.haptic, ViewsIndex.gradientOnImage]
                        } label: {
                            Text("Test Navigation Path")
                        }
                    }
                }
                
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
