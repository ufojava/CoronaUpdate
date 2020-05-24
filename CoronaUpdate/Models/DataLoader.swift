//
//  DataLoader.swift
//  CoronaUpdate
//
//  Created by Ufuoma Okoro on 21/05/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//


 
 
 
import Foundation
import SwiftUI

class CountryDetails: ObservableObject {
    
    @Published var country = "nigeria"
    
    
    
}



//Data Structure
struct CoronaDataStructure: Codable {
    
    var Country: String
    var CountryCode: String
    var Confirmed: Int
    var Deaths: Int
    var Recovered: Int
    var Active: Int
    var Date:   String
    
    
    
}//End of CoronaDataStructure Template




