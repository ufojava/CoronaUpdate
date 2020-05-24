//
//  DataLoader.swift
//  CoronaUpdate
//
//  Created by Ufuoma Okoro on 21/05/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//

/*API Corona Data

 URL - 'https://api.covid19api.com/all' all Countries no data
  URL - 'https://api.covid19api.com/live/country/south-africa' by country
 URL -  'https://api.covid19api.com/live/country/south-africa/status/confirmed' Total
 URL - https://api.covid19api.com/total/country/south-africa/status/confirmed?from=2020-03-01T00:00:00Z&to=2020-04-01T00:00:00Z
 
 
 */
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


/*
 (1) Declare API URL
 (2) Create API URL Session
 (3) Decode JSON API Data
 */


struct CoronaAPISession {
    
    @ObservedObject var countryDetails = CountryDetails()
    @EnvironmentObject var coronaCountryDetails: CountryDetails
    
    
    
    
    
        //Funciton to process data
        func loadCoronaData(completion: @escaping ([CoronaDataStructure]) -> ()) {
            
            //let localCountryDetails = countryDetails.country
            //let localCountryDetails = coronaCountryDetails.country
            //let localCoronaDetails = coronaCountryDetails.country
            
        
        
                //Declare URL Session
            guard let url = URL(string: "https://api.covid19api.com/live/country/\([self.coronaCountryDetails.country])/status/confirmed") else {
                    
                    print("Unable to find URL")
                    return
                    
                }//End URL Check
        
                //Create URL Request
                let request = URLRequest(url: url)
        
        //Create Request URL Session
        URLSession.shared.dataTask(with: request) {data,response, error in
            
                //Create Data from retreived data
                if let data = data {
                    
                    if let decodedResponse = try? JSONDecoder().decode([CoronaDataStructure].self, from: data) {
                        
                        
                        
                        DispatchQueue.main.async {
                            completion(decodedResponse)
                        }
                        
                        
                        
                    }
                }
            
            
            
            //Data will not come if resume is not put
            }.resume()//End of URL Session
        
        
        
    }//End of function
    
    

    
}//End of Class


