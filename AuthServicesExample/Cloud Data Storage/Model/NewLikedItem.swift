//
//  NewLikedItem.swift
//  AuthServicesExample
//
//  Created by Tom Wu on 2023-06-09.
//

import Foundation

/*
 This structure is used to write a single row to this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/12wBgt2ByVAilQle7GaduBfq3uf4ZLpZU3i-CIG8ypVM/edit#gid=0
 
 ... accessed via this endpoint:
 
 https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/mealItems/likes
 */
/// - Tag: add_row_to_spreadsheet
struct NewLikedItem: Codable {
    
    // NOTE: Sheety requires that the property name be "row"
    let like: LikedItem

    // Sends the new row to the endpoint
    func encodeAndWriteToEndpoint() async throws {
        
        // Create an encoder object
        let encoder = JSONEncoder()
        
        // Ensure generated JSON is easy to read
        encoder.outputFormatting = .prettyPrinted
        
        // Actually encode the data contained within this structure ('self')
        guard let encoded = try? encoder.encode(self) else {
            throw JSONSendError.encodingFailed
        }
        
        // DEBUG: What has been encoded?
        #if DEBUG
        print("DEBUG: Data that will be sent to Sheety is: ")
        print(String(data: encoded, encoding: .utf8)!)
        #endif
    
        // 2. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: LikedItems.endpoint)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        do {
            // 3. Run that request and process the response
            let (responseFromSheety, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            #if DEBUG
            // The response from Sheety...
            // NOTE: If successful, you should see a JSON object that has the row number of the new entry in the spreadsheet
            print("DEBUG: Sheety service response is: \(String(data: responseFromSheety, encoding: .utf8)!)")
            #endif

        } catch {
            
            #if DEBUG
            // Show an error that we wrote and understand
            print("DEBUG: Count not send data to endpoint.")
            print("----")
            #endif
            
            #if DEBUG
            // Show a detailed error to help with debugging
            print(error)
            #endif
            return

        }
                
    }
    
}
