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
                    Image(systemName: "arrow.up.circle")
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
    
    func saveAndSendUserInformation() async {
        
//        // Get current date and time as a string
//        // For other formatting options, see:
//        // https://developer.apple.com/documentation/foundation/dateformatter
//        let df = DateFormatter()
//        df.dateFormat = "dd-MM-yyyy HH:mm:ss"
//        let now = df.string(from: Date())
//        
//        // Record user's mood on this visit to the app, for posterity
//        let thisMealItem = MealItem(date: now,
//                              meal: sharedAuthenticationStore.userName,
//                              item: sharedAuthenticationStore.userEmail,
//                              mood: Int(mood))
//        
//        // Set visit information up to be sent to remote spreadsheet
//        let newRowInSpreadsheet = NewMealItem(row: thisMealItem)
//        
//        // Actually encode and send the user's information
//        do {
//            try await newRowInSpreadsheet.encodeAndWriteToEndpoint()
//        } catch JSONSendError.encodingFailed {
//            #if DEBUG
//            print("DEBUG: Could not encode data to JSON.")
//            #endif
//        } catch {
//            #if DEBUG
//            print("DEBUG: Something else unexpected went wrong.")
//            #endif
//        }
//        
//        // Track times mood has been shared
//        moodShareCount += 1
        
    }
    
}


struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView()
    }
}
