//
//  CoronaDataView.swift
//  CoronaUpdate
//
//  Created by Ufuoma Okoro on 21/05/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//


//CoronaData Views
import SwiftUI



struct CoronaView: View {
    
    //Assign loaded Data to State variable
    @State private var countryStats: [CoronaDataStructure] = []
    @EnvironmentObject var coronStats: CountryDetails
    
     @ObservedObject var countryDetails = CountryDetails()
    
    
   //@State private var updateCountry = "nigeria"
    
    func updateCountry() {
        
        //self.coronCountryDetails = "south-africa"
        
        
    }
    
    
    
    
    var body: some View {
        
        VStack {
        //TextField("Country", text: $updateCountry)
            Text("\(self.coronStats.country)")
            //Text("Hello")
                
        ///*
       
        List {
            
            ForEach(countryStats,id: \.Date) { country in
                
                VStack {
                    
                    
                    
                    Text(country.Country)
                    Text(country.CountryCode)
                    Text("\(country.Confirmed)")
                    Text("\(country.Deaths)")
                    Text("\(country.Recovered)")
                    Text("\(country.Active)")
                    Text(country.Date)
                 
                
                    
                    
                
                }
                
            }
            
            
            
            
            
        }//End of List
            .onAppear() {
                
                //self.coronaCountryDetails.country = "south-africa"
                //self.countryDetails.country = "south-africa"
                //self.coronStats.country = "south-africa"
            
                
                CoronaAPISession().loadCoronaData { country in
                    
                    self.countryStats = country
                    
                    
                    
                    
                }
                
                
                
        }//End of Appear
            
            //*/
        
        }
    }
    
}





//CoronaView Previews
struct CoronaView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CoronaView()
        
    }
    
}

struct CoronaAPIData: View {
    
    //Environmental and Observed Obects
    @State private var countryStats: [CoronaDataStructure] = []
    @EnvironmentObject var coronStats: CountryDetails
    
    var body: some View {
        
        
        List {
            
            ForEach(countryStats,id: \.Date) { country in
                
                VStack {
                    
                    
                    
                    Text(country.Country)
                    Text(country.CountryCode)
                    Text("\(country.Confirmed)")
                    Text("\(country.Deaths)")
                    Text("\(country.Recovered)")
                    Text("\(country.Active)")
                    Text(country.Date)
                 
                
                    
                    
                
                }
                
            }
            
            
            
            
            
        }//End of List
            .onAppear() {
                
                //self.coronaCountryDetails.country = "south-africa"
                //self.countryDetails.country = "south-africa"
                self.coronStats.country = "nigeria"
            
                
                self.loadCoronaData { country in
                    
                    self.countryStats = country
                    
                    
                    
                    
                }
                
                
                
        }//End of Appear
        
        
        
        
    }
    
    //Funciton to process data
        func loadCoronaData(completion: @escaping ([CoronaDataStructure]) -> ()) {
            
            //let localCountryDetails = countryDetails.country
            //let localCountryDetails = coronaCountryDetails.country
            //let localCoronaDetails = coronaCountryDetails.country
            
        
        
                //Declare URL Session
            guard let url = URL(string: "https://api.covid19api.com/live/country/\(self.coronStats.country)/status/confirmed") else {
                    
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
    
    
    
    
}
