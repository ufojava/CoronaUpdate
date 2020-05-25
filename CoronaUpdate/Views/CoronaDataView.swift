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
        
   Text("Place Holder")
        
        }
    
    
}





//CoronaView Previews
struct CoronaView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CoronaView()
        
    }
    
}

struct CoronaAPIData: View {
    
    
    /*API Corona Data

    URL - 'https://api.covid19api.com/all' all Countries no data
     URL - 'https://api.covid19api.com/live/country/south-africa' by country
    URL -  'https://api.covid19api.com/live/country/south-africa/status/confirmed' Total
    URL - https://api.covid19api.com/total/country/south-africa/status/confirmed?from=2020-03-01T00:00:00Z&to=2020-04-01T00:00:00Z
    URL - https://api.covid19api.com/countries Country List
 */
    
    //Environmental and Observed Obects
    @State private var countryStats: [CoronaDataStructure] = []
    @EnvironmentObject var coronStats: CountryDetails
    @ObservedObject var countries = JsonDataLoader() //Country List from JSON File
    
    @State private var inSearchCountry = ""
    @State private var selectedRow = ""
    
    //Check if Insearch is blank
    @State private var inCountryStatus = false
    @State private var runCoronaData = false
    
    
    //Function to get countryname
    func getCountryName() -> some View {
        
        
        
        
         
        
        
   return     VStack {
                   
            
              
                   Form {
                       
                    TextField("Enter Country", text: $inSearchCountry)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    
                    
                   
                        
                    
                       
                       List {
                       
                       
                               ForEach(countries.jsonFileData.sorted(by: {$0.Slug < $1.Slug}).filter {$0.Slug .contains(self.inSearchCountry)},id: \.ISO2) { country in
                                   
                                   Text(country.Slug)
                                       .onTapGesture {
                                           self.selectedRow = country.Slug
                                        
                                            
                                     
                                        
                                   }
                                       
                                   
                                   
                                   
                                   
                               }
                       
                       }//End of List
                       
                       
                       
                   }//End of Form
                   

               
           }//End of VStack
        
        
         
        
        
        
    }//End of Get Country Name
    
    
    

    
    
    //Function to pull data
    func getCountryData(inCountry: String) -> some View {
        
        
        return List {
            
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
                
            }//End ForEach
            
            
            
            
            
        }//End of List
            .onAppear() {
                
        
                self.coronStats.country = inCountry
            
                
                self.loadCoronaData { country in
                    
                    self.countryStats = country
                    
                    
                    
                    
                }
                
                
                
        }//End of Appear
        
        
        
        
        
        
    }//End of Function
    
    

    
    var body: some View {
        VStack {
            
            
            HStack {
     
            
                    Button(action: {
                        
                        self.inCountryStatus = true
                        
                        
                        
                    }) {
                        
                        
                        
                        Text("Search Country")
                        
                        
                        
                    }
                    
                    if self.inCountryStatus {
                        
                        self.getCountryName()
                        
                        
                        
                    }
                
                
                Button(action: {
                    
                    if self.selectedRow != "" {
                        
                
                    self.runCoronaData.toggle()
                        
                    }
                    
                    self.hideKeyboard()
                    
                    
                }) {
                    
                    Text("Get Stats")
                    
                    
                }
                
                if self.runCoronaData {
                    
                    getCountryData(inCountry: "\(self.selectedRow)")
                    
                    
                    
                }

            }
        
        }
        
        
    }//End of Body
    
    
    
    //Funciton to process data
        func loadCoronaData(completion: @escaping ([CoronaDataStructure]) -> ()) {
            
      
        
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
    
    
    
    
}//End API Struct

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
    
    
    



//Test struct to list JSON Data

struct TestJSONData: View {
    
    @ObservedObject var countries = JsonDataLoader()
    @State private var selectedRow = ""
    @State private var inSearchCountry = ""
    

    
    
    
    
    var body: some View {
        VStack {
            
            Text("\(self.selectedRow)")
            
            
        
       
            Form {
                
                TextField("Enter Country", text: $inSearchCountry).autocapitalization(.none)
                
                List {
                
                
                ForEach(countries.jsonFileData.sorted(by: {$0.Slug < $1.Slug}).filter {$0.Slug .contains(self.inSearchCountry)},id: \.ISO2) { country in
                    
                    Text(country.Slug)
                        .onTapGesture {
                            self.selectedRow = country.Slug
                    }
                        
                    
                    
                    
                    
                }
                
                }
                
                
                
            }
            
            
            
        
        
    }
    }
    
}
