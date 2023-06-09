//
//  LikedItems.swift
//  AuthServicesExample
//
//  Created by Tom Wu on 2023-06-09.
//

import Foundation

/*
 This structure will be populated with rows from this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/12wBgt2ByVAilQle7GaduBfq3uf4ZLpZU3i-CIG8ypVM/edit#gid=0
 
 ... accessed via this endpoint:
 
 https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/mealItems/likes
 
 */
/// - Tag: entire_spreadsheet_structure
struct LikedItems: Codable {
    
    // Will eventually be populated with data matching all the rows of the spreadsheet
    // Begins as an empty list
    var likes: [LikedItem] = []
    
    // Defines the endpoint for reading/writing spreadsheet data
    // NOTE: This must be updated to point at the endpoint from your Sheety project
    /// - Tag: update_endpoint
    static let endpoint = "https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/mealItems/likes"
    
}
