//
//  CheckingAuthenticationStatusView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2023-05-30.
//

import SwiftUI

struct CheckingAuthenticationStatusView: View {
    
    let withService: AuthenticationService
    
    var body: some View {
        VStack {
            Spacer()
            ProgressView("Checking authentication status with \(withService.rawValue)…")
            Spacer()
        }
    }
}

struct CheckingAuthenticationStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CheckingAuthenticationStatusView(withService: .apple)
    }
}
