//
//  AuthServicesExampleApp.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

@main
struct AuthServicesExampleApp: App {
    
    // Create a source of truth for Google Sign-In activity
    @StateObject var googleAuthenticationStore = GoogleAuthentication()

    // Create a source of truth for Apple Sign-In activity
    @StateObject var appleAuthenticationStore = AppleAuthentication()

    // Create a source of truth for overall sign in activity
    @StateObject var sharedAuthenticationStore = SharedAuthentication()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WelcomeView()
                    // Make Google Sign-In information available to other views through the environment
                    .environmentObject(googleAuthenticationStore)
                    // Make Apple Sign-In information available to other views through the environment
                    .environmentObject(appleAuthenticationStore)
                    // Make overall sign in information available to other views through the environment
                    .environmentObject(sharedAuthenticationStore)
                    // Required to open app again after popping out to perform sign-in with Google
                    .onOpenURL { url in
                        GIDSignIn.sharedInstance.handle(url)
                    }

            }
        }
    }
}
