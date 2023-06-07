//
//  TodayView.swift
//  AuthServicesExample
//
//  Created by Tom Wu on 2023-06-07.
//

import SwiftUI

struct TodayView: View {
    
    // MARK: Stored properties
    @EnvironmentObject var dataStore: MealItemsStore
    
    // MARK: Computed properties
    var body: some View {
        NavigationView{
            List {
                Section(content: {
                    ForEach(dataStore.mealItems.rows) { item in
                        //Text(item.meal)
                        if item.meal == "Breakfast" {
                            Text(item.item)
                        }
                    }
                }, header: {
                    Text("Breakfast")
                })
                
                Section(content: {
                    ForEach(dataStore.mealItems.rows) { item in
                        //Text(item.meal)
                        if item.meal == "Lunch" {
                            Text(item.item)
                        }
                    }
                }, header: {
                    Text("Lunch")
                })
                
                Section(content: {
                    ForEach(dataStore.mealItems.rows) { item in
                        //Text(item.meal)
                        if item.meal == "Dinner" {
                            Text(item.item)
                        }
                    }
                }, header: {
                    Text("Dinner")
                })
            }
            .listStyle(.grouped)
        }

    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
