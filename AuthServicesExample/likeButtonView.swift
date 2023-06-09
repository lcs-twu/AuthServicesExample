//
//  likeButtonView.swift
//  AuthServicesExample
//
//  Created by Tom Wu on 2023-06-07.
//

import SwiftUI

struct likeButtonView: View {
    
    @EnvironmentObject var sharedAuthenticationStore: SharedAuthentication
    
    @EnvironmentObject var dataStore: MealItemsStore
    
    @State private var likeShareCount = 0
    
    @State private var isLiked = false
    var body: some View {
        Button(action: {
                    self.isLiked.toggle()
                }){Image(systemName: isLiked ? "heart.fill" : "heart")
                Text(isLiked ? "Liked" : "Like")
                    
                        if isLiked == true{
                            Text("testing")
                        }
                    
            }
    }
    
    func upLoadLikes() async{
        //        // https://developer.apple.com/documentation/foundation/dateformatter
        //
        let df = DateFormatter()
                df.dateFormat = "dd-MM-yyyy HH:mm:ss"
                let now = df.string(from: Date())
        
//        let thisItem = MealItem(date: now,
//                                name: sharedAuthenticationStore.userName,
//                                email: sharedAuthenticationStore.userEmail)
    }
    
}

//func saveAndSendUserInformation() async {
    
    //        // Get current date and time as a string
    //        // For other formatting options, see:
    //        // https://developer.apple.com/documentation/foundation/dateformatter
    //
    
//}




//func saveAndSendUserInformation() async {
//
//        // Get current date and time as a string
//        // For other formatting options, see:
//        // https://developer.apple.com/documentation/foundation/dateformatter
//        let df = DateFormatter()
//        df.dateFormat = "dd-MM-yyyy HH:mm:ss"
//        let now = df.string(from: Date())
//
//        // Record user's mood on this visit to the app, for posterity
//        let thisVisit = Visit(date: now,
//                              name: sharedAuthenticationStore.userName,
//                              email: sharedAuthenticationStore.userEmail,
//                              mood: Int(mood))
//
//        // Set visit information up to be sent to remote spreadsheet
//        let newRowInSpreadsheet = NewVisit(row: thisVisit)
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
//
//    }

struct likeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        likeButtonView()
    }
}
