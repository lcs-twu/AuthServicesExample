//
//  AuthenticatedView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-06.
//

import SwiftUI

// This view is only shown when the user has been authenticated
// Customize as needed – this is the first view the user will see after logging in to your app
/// - Tag: accessing_user_details
struct AuthenticatedView: View {
    
    // Access to shared authentication information
    @EnvironmentObject var sharedAuthenticationStore: SharedAuthentication
    
    // Track user's mood
    //@State private var mood: Double = 3
    
    // Obtains data from the spreadsheet
    @StateObject private var dataStore = MealItemsStore()
    @StateObject private var likedItemsStore = LikedItemsStore()

    // How many times has this user shared their mood?
    //@State private var moodShareCount = 0
    
    var body: some View {
        
        TabView{
            Text("Yesterday")
                .tabItem {
                    Image(systemName: "arrow.left.circle")
                    Text("Yesterday")
                }
            TodayView()
                .tabItem {
                    Image(systemName: "sun.haze.circle")
                    Text("Today")
                }
            Text("Tomorrow")
                .tabItem {
                    Image(systemName: "arrow.right.circle")
                    Text("Tomorrow")
                }
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .environmentObject(dataStore)
        .environmentObject(likedItemsStore)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                // Sign out button for whatever service the user signed in with
                SignOutButtonView()
            }
        }
        .padding()
        .onAppear() {
            Task {
                await dataStore.refreshFromRemoteJSONSource()
                //moodShareCount = 0
            }
        }
        
    }

    
}


struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView()
    }
}
