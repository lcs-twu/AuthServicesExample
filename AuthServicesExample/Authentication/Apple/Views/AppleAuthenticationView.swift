//
//  AppleAuthenticationView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import SwiftUI

struct AppleAuthenticationView: View {
    
    // Access to Apple authentication information
    @EnvironmentObject var appleAuthenticationStore: AppleAuthentication
    
    // Access to Google authentication information
    @EnvironmentObject var googleAuthenticationStore: GoogleAuthentication
    
    var body: some View {

        Group {
            
            if appleAuthenticationStore.userStatus == .indeterminate {
                
                CheckingAuthenticationStatusView(withService: .apple)
                
            } else if appleAuthenticationStore.userStatus == .signedIn {

                // When user is signed in to Apple, show information from that source
                AppleUserInfoView()
                
            } else {

                if googleAuthenticationStore.userStatus == .indeterminate || googleAuthenticationStore.userStatus == .signedOut {
                    
                    WelcomeMessageView()
                        .padding(10)

                    AppleSignInView()

                }
                
            }
            
        }
        .onAppear {
            
            // Automatically sign in the user when the user opens the main page and they have already authenticated
            appleAuthenticationStore.restoreSignIn()
        }
        
    }
}

struct AppleAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AppleAuthenticationView()
    }
}
