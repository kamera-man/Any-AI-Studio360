//
//  ContentView.swift
//  Studio360
//
//  Created on Nov 18, 2025
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            AlbumListView()
                .tabItem {
                    Label("Albums", systemImage: "folder.fill")
                }
                .tag(1)
            
            PhotoGridView()
                .tabItem {
                    Label("Photos", systemImage: "photo.stack.fill")
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
