//
//  VisitorsStore.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-07.
//

import Foundation

/*
 An instance of this class will load all rows from this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/15LiZ_NR-z4QqCRIYlrkOBrmVSw_-YTvqR7LXsASlb4A/edit#gid=0
 
 ... accessed via this endpoint:
 
 https://api.sheety.co/5f7fc5b0a8e6fea14ccaeba82368c529/menu/rows
 
 Or optionally, load data from a local JSON file.
 
 */
/// - Tag: load_rows_from_spreadsheet
class VisitorsStore: ObservableObject {
    
    // MARK: Stored properties
    @Published var visitors = Visitors()
    
    // MARK: Initializer
    init(loadFromRemote: Bool = true) {
        
        // By default load from a remote data source
        if loadFromRemote {
            
            Task {
                await refreshFromRemoteJSONSource()
            }

        } else {
            
            // Otherwise load data from a local JSON file to save network traffic and usage of API
            loadFromLocalJSONSource()
            
        }
        
    }
    
    // MARK: Functions
    
    // Populates visitors data from the JSON endpoint
    func refreshFromRemoteJSONSource() async {
        
        // 1. Prepare a URLRequest to obtain the list of visitors
        let url = URL(string: Visitors.endpoint)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // 2. Run the request and process the response
        do {
            // Fetch the data
            let (dataFromSheety, _) = try await URLSession.shared.data(from: url)
            
            #if DEBUG
            // DEBUG: Print the data received from the Sheety endpoint
            print("DEBUG: Data received from Sheety is:")
            print("------------------------------------")
            print(String(data: dataFromSheety, encoding: .utf8)!)
            print("------------------------------------")
            #endif
            
            // Create a decoder object to do most of the work for us
            let decoder = JSONDecoder()
            
            // Use the decoder object to convert the raw data into an instance of the Visitors data type
            let decodedData = try decoder.decode(Visitors.self, from: dataFromSheety)
            
            #if DEBUG
            // Print a status message to the console
            print("Data decoded from JSON from Sheety API endpoint successfully")
            #endif

            // Set the list of visitors that have been downloaded
            // NOTE: Here we update the observed property on the main thread (not permitted to update a published property on a background thread)
            // SEE: https://stackoverflow.com/a/74318973/5537362
            await MainActor.run {
                self.visitors.rows = decodedData.rows
            }

        } catch {
            
            #if DEBUG
            // Could not decode the JSON
            print("DEBUG: Could not retreive data from endpoint, or, raw JSON data from endpoint could not be decoded.")

            // Print a useful error message
            print(error)
            #endif
        }
    }
    
    // Populates visitors data from a local file included in app bundle
    func loadFromLocalJSONSource() {
        
        if let url = Bundle.main.url(forResource: "visitors", withExtension: "json") {
            do {
                
                let dataFromAppBundle = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Visitors.self, from: dataFromAppBundle)
                
                #if DEBUG
                // Print a status message to the console
                print("Successfully decoded data from the JSON file that was obtained from the app bundle")
                #endif
                
                // Set the list of visitors
                self.visitors.rows = decodedData.rows
                                    
            } catch {

                #if DEBUG
                // Could not decode the JSON
                print("Raw JSON data from app bundle could not be decoded.")

                // Print a useful error message
                print(error)
                #endif

            }
        }
    }
    
}

// Create a test store for use with Xcode previews
let testStore = VisitorsStore(loadFromRemote: false)
