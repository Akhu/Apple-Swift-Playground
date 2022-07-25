//
//  SearchableScopeView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 25/07/2022.
//

import SwiftUI

struct Message: Identifiable, Codable {
    let id: Int
    var user: String
    var text: String
}
enum SearchScope: String, CaseIterable {
    case inbox, favorites
}
//https://raw.githubusercontent.com/AsyncAgency/Playground-Apple/main/SwiftUIPlayground/SwiftUIPlayground/searchableFavorites.json
//https://raw.githubusercontent.com/AsyncAgency/Playground-Apple/main/SwiftUIPlayground/SwiftUIPlayground/searchableInbox.json


struct SearchableScopeView: View {
    @State private var messages = [Message]()
    
    @State private var searchText = ""
    @State private var searchScope: SearchScope = .inbox
    
    var body: some View {
        List {
            ForEach(filteredMessages) { message in
                VStack(alignment: .leading) {
                    Text(message.user)
                        .font(.headline)
                    
                    Text(message.text)
                }
            }
        }.searchable(text: $searchText, scope: $searchScope){
            ForEach(SearchScope.allCases, id: \.self) { scope in
                Text(scope.rawValue.capitalized)
            }
        }
        .onAppear {
            runSearch()
        }
        .onSubmit(of: .search, runSearch)
        .onChange(of: searchScope) { _ in runSearch() }
        .navigationTitle("Searchable Scope")
    }
    
    var filteredMessages : [Message] {
        if searchText.isEmpty {
            return messages
        } else {
            return messages.filter { $0.text.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    func runSearch() {
        Task {
            guard let url = URL(string: "https://raw.githubusercontent.com/AsyncAgency/Playground-Apple/main/SwiftUIPlayground/SwiftUIPlayground/searchable\(searchScope.rawValue.capitalized).json") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([Message].self, from: data)
        }
    }
}

struct SearchableScopeView_Previews: PreviewProvider {
    static var previews: some View {
        SearchableScopeView()
    }
}
