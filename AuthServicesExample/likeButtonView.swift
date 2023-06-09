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
    
    let mealItem: MealItem
    
    var body: some View {
        Button(action: {
            Task{
                await uploadUserInformation()
            }
        }, label:{
            Image(systemName: "hand.thumbsup")
        })
        
        Group {
            // How many people have shared their mood?
            Text("Results")
                .bold()
                .padding(.top)
            
            Text("\(dataStore.mealItems.rows.count + likeShareCount)")
        }
//        Task {
//            await dataStore.refreshFromRemoteJSONSource()
//            likeShareCount = 0
//        }
    }
    

    
    func uploadUserInformation() async{
        let thisLikedItem = LikedItem(name: sharedAuthenticationStore.userName, email: sharedAuthenticationStore.userEmail, likedItemId: mealItem.id)
        
        let newRowInSpreadsheet = NewLikedItem(row: thisLikedItem)
        
        do {
            try await newRowInSpreadsheet.encodeAndWriteToEndpoint()
        } catch JSONSendError.encodingFailed {
#if DEBUG
            print("DEBUG: Could not encode data to JSON.")
#endif
        } catch {
#if DEBUG
            print("DEBUG: Something else unexpected went wrong.")
#endif
        }
    }
}





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
//
//struct likeButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        likeButtonView()
//    }
//}
