//
//  GoogleAuthenticationView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import GoogleSignIn
import SwiftUI

struct GoogleAuthenticationView: View {

    // Access to Apple authentication information
    @EnvironmentObject var appleAuthenticationStore: AppleAuthentication

    // Access to Google authentication information
    @EnvironmentObject var googleAuthenticationStore: GoogleAuthentication

    var body: some View {

        Group {
            
//            if googleAuthenticationStore.userStatus == .indeterminate {
//
//                CheckingAuthenticationStatusView(withService: .google)
//
//            } else
            if googleAuthenticationStore.userStatus == .signedIn {

                // When user is signed in to Apple, show information from that source
                GoogleUserInfoView()
                
            } else {

                if appleAuthenticationStore.userStatus == .indeterminate || appleAuthenticationStore.userStatus == .signedOut {
                    
                    GoogleSignInView()

                }
                
            }

        }
        .onAppear {
            
            // Automatically sign in the user when the user opens the main page and they have already authenticated
            googleAuthenticationStore.restoreSignIn()

        }

    }
}

struct GoogleAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleAuthenticationView()
    }
}
