//
//  GoogleAuthentication.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2023-05-30.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

enum GoogleAuthenticationStatus {
    case signedIn           // User is signed in
    case signedOut          // User explicitly signed out
    case indeterminate      // App closed or backgrouded
}

class GoogleAuthentication: ObservableObject {
    
    @Published var userStatus: GoogleAuthenticationStatus = .indeterminate
    
    func restoreSignIn() {
        
        // DEBUG
        #if DEBUG
        print("DEBUG: Restoring sign-in with Google")
        #endif
        
        if userStatus == .indeterminate {
            
            // Check whether app was backgrounded or force quit after explicitly signing out
            let defaults = UserDefaults.standard
            let explicitlySignedOut = defaults.bool(forKey: signedOutKey)
            
            if !explicitlySignedOut {
                
                #if DEBUG
                print("DEBUG: User not explicitly signed out.")
                #endif

                // Check whether user is already signed in
                GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                    // Check if `user` exists; otherwise, do something with `error`
                    guard let user = user, let _ = user.profile else {

                        // Not logged in
                        #if DEBUG
                        print("DEBUG: User is not already signed in.")
                        #endif
                        
                        return
                    }
                    
                    #if DEBUG
                    print("DEBUG: User is already signed in.")
                    #endif

                    // User is logged in
                    self.userStatus = .signedIn

                    // Save to UserDefaults that user is signed in
                    let defaults = UserDefaults.standard
                    defaults.setValue(false, forKey: signedOutKey)
                }


            } else {
                
                // User is signed out; must set this so that Google button appears after app is force-quit or backgrounded
                self.userStatus = .signedOut
                
            }

        }
        
    }
    
}
