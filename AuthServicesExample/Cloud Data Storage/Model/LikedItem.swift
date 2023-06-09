//
//  LikedItem.swift
//  AuthServicesExample
//
//  Created by Tom Wu on 2023-06-09.
//

import Foundation

/*
 Each instance of this structure corresponds to a single row in this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/12wBgt2ByVAilQle7GaduBfq3uf4ZLpZU3i-CIG8ypVM/edit#gid=0
 
 The `id` property is the row number in the spreadsheet.
 
 Other properties match the columns of the spreadsheet, from left to right.

 The spreadsheet is accessed via this endpoint:
 
 https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/mealItems/likes
 
 */

struct LikedItem: Codable, Identifiable {
    
    
    let name: String
    let email: String
    let likedItemId: Int
    
    var id: Int = 0     // Will be replaced with each row's number...
                        // A default is required to simplify logic to add a new row
                        // when sending data to Sheety

}
