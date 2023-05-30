//
//  GoogleSignInView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

struct GoogleSignInView: View {
    
    // Access to Google authentication information
    @EnvironmentObject var googleAuthenticationStore: GoogleAuthentication

    // To allow us to determine color scheme of device
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        if colorScheme == .dark {
            
            GoogleSignInButtonDark()
                .frame(width: 210, height: 50, alignment: .center)
                .padding()
                .onTapGesture {
                    handleSignInButton()
                }

        } else {

            GoogleSignInButtonLight()
                .frame(width: 210, height: 50, alignment: .center)
                .padding()
                .onTapGesture {
                    handleSignInButton()
                }

        }
        
    }
    
    func handleSignInButton() {
        
        // SEE: https://github.com/WesCSK/SwiftUI-Firebase-Authenticate-Using-Google-Sign-In
        // ... for source of how to obtain the root view controller for GIDSignIn use
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        guard let root = screen.windows.first?.rootViewController else {
            return
        }

        // Attempt to sign in with Google
        GIDSignIn.sharedInstance.signIn(withPresenting: root) { signInResult, error in
            
            
            guard let result = signInResult,
                  let _ = result.user.profile else {
                // Inspect error
                return
            }
                                    
            // Successful login
            #if DEBUG
            print("DEBUG: ", terminator: "")
            print("Authorization with Google Sign In successful!")
            #endif
            googleAuthenticationStore.userStatus = .signedIn
        }
    }

}

struct GoogleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInView()
    }
}
