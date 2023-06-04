//
//  Visit.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-07.
//

import Foundation

/*
 Each instance of this structure corresponds to a single row in this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/15LiZ_NR-z4QqCRIYlrkOBrmVSw_-YTvqR7LXsASlb4A/edit#gid=0

 The `id` property is the row number in the spreadsheet.
 
 Other properties match the columns of the spreadsheet, from left to right.

 The spreadsheet is accessed via this endpoint:
 
 https://api.sheety.co/5f7fc5b0a8e6fea14ccaeba82368c529/menu/rows
 
 */
/// - Tag: spreadsheet_row_structure
struct Visit: Codable, Identifiable {
    
    let date: String
    let name: String
    let email: String
    let mood: Int
    var id: Int = 0     // Will be replaced with each row's number...
                        // A default is required to simplify logic to add a new row
                        // when sending data to Sheety

}
