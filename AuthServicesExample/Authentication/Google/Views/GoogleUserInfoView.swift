//
//  GoogleUserInfoView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import GoogleSignIn
import SwiftUI

struct GoogleUserInfoView: View {
    
    // Access to Google Sign-in information
    @EnvironmentObject var googleAuthenticationStore: GoogleAuthentication
    
    // Access to shared authentication information
    @EnvironmentObject var sharedAuthenticationStore: SharedAuthentication
    
    var body: some View {
        
        AuthenticatedView()
            .onAppear() {
                
                sharedAuthenticationStore.loggedInWithService = .google
                
                guard let user = GIDSignIn.sharedInstance.currentUser,
                      let profile = user.profile else {
                    // Not logged in
                    #if DEBUG
                    print("DEBUG: Unexpected error; in GoogleUserInfoView – should be authenticated but user information not available.")
                    return
                    #endif
                }

                sharedAuthenticationStore.userName = profile.name
                sharedAuthenticationStore.userEmail = profile.email
            }
        
    }
}

struct GoogleUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleUserInfoView()
    }
}
