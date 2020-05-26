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
    URL - https://api.covid19api.com/total/country/south-africa - Live

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
    
    
    @State private var showIntroImage = false
    @State private var showIntroTextOne = false
    @State private var showIntroTextTwo = false
    
    var arrayList = [1,2,3,4,5]
    

    
    
    //Function to get countryname
    func getCountryName() -> some View {
        
        
        
        
         
        
        
   return     VStack {
                   
            
              
                  
                        VStack {
                            TextField("Enter Country", text: $inSearchCountry)
                                                .autocapitalization(.none)
                                                .disableAutocorrection(true)
                                                .padding()
                            
                        }
                            
                    
                    
                   
                        
                    
                       
                       List {
                       
                       
                               ForEach(countries.jsonFileData.sorted(by: {$0.Slug < $1.Slug}).filter {$0.Slug .contains(self.inSearchCountry)},id: \.ISO2) { country in
                                   
                                   Text(country.Slug)
                                       .onTapGesture {
                                           self.selectedRow = country.Slug
                                        
                                        
                                        
                                            
                                     
                                        
                                   }
                                       
                                   
                                   
                                   
                                   
                               }
                       
                       }//End of List
                       
                       
                       
                  // }//End of Form
                   

               
           }//End of VStack
        
        
         
        
        
        
    }//End of Get Country Name
    
    
    

    
    
    //Function to pull data
    func getCountryData(inCountry: String) -> some View {
        
        
        return List {
            
            ForEach(countryStats,id: \.Date) { country in
                
                VStack(alignment: .leading) {
                    
                    
                    
                    Text("Confirmed: \(country.Confirmed)")
                    Text("Deaths: \(country.Deaths)").foregroundColor(Color.red)
                    Text("Recovered: \(country.Recovered)").foregroundColor(Color.green)
                    Text("Active: \(country.Active)")
                    Text("Date:\(country.Date)")
                 
                
                }.padding()
                
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
        
        ZStack(alignment: .top) {
            
            LinearGradient(gradient: Gradient(colors: [.blue,.white, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width:450,height: 220)
                .overlay(Rectangle().stroke(Color.black,lineWidth: 2))
                .shadow(radius: 2)
                .edgesIgnoringSafeArea(.all)
            
            
        
        
        VStack {
            
            
            
                        HStack {
                 
                        
                                Button(action: {
                                    
                                   
                                    
                                    
                                    if self.showIntroTextOne {
                                        
                                        withAnimation {
                                                                           
                                            self.showIntroTextOne = false
                                        }
                                    }
                                                                       
                                    
                                                                        
                                    if self.showIntroImage {
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            
                                            withAnimation {
                                                
                                                self.showIntroImage = false
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                   
                                    if self.showIntroTextTwo {
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            
                                            
                                            withAnimation {
                                                
                                                self.showIntroTextTwo = false
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        
                                        
                                         self.inCountryStatus = true
                                        
                                    }
                                    
                                    
                                    
                                }) {
                                    
                                    
                                    
                                    Text("Input Country")
                                        .frame(width: 130,height:40)
                                        .foregroundColor(Color.red)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                                    
                                    
                                        .onAppear() {
                                            
                                                self.showIntroTextOne = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                
                                                withAnimation {
                                                
                                                
                                                self.showIntroImage = true
                                                    
                                                }
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                
                                                withAnimation {
                                                
                                                self.showIntroTextTwo = true
                                                }
                                            }
                                            
                                        
                                    }
                                               
                    
                                }
                                
                               
                            
                            
                            
                            Button(action: {
                                
                                self.inCountryStatus = false
                                
                                if self.selectedRow != "" {
                                    
                            
                                self.runCoronaData.toggle()
                                    
                                }
                                
                                self.hideKeyboard()
                                
                                
                            }) {
                                
                                Text("Get / Clear Data")
                                    .frame(width: 130,height:40)
                                    .foregroundColor(Color.blue)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                                
                                
                            }
                            
                           

                        }//End of HStack
            
           
            
            
            Spacer().frame(height:10)
            
            Text("Your Selection: \(self.selectedRow.uppercased())")
           
            
            Spacer()
            
         
            
            VStack {
                  
                if self.showIntroTextOne {
                
                    Text("Covid-19 Global").bold()
                        .transition(.slide)
                        .animation(.default)
                }
                
                if self.showIntroImage {
              
            
                    Image("Globe1")
                        .resizable()
                        .frame(width:300,height: 300)
                        .scaledToFill()
                        .transition(.slide)
                        .animation(.default)
                }
                
                if self.showIntroTextTwo {
                
                    Text("Statistics").bold()
                        .transition(.slide)
                        .animation(.default)
                        
                }
                
            }
            Spacer()
        
        
            
            //Input Country Name
            if self.inCountryStatus {
                                               
               self.getCountryName()
               
           }
            
            //Show Country Data
            
            if self.runCoronaData {
                                           
               getCountryData(inCountry: "\(self.selectedRow)")
               
               
               
           }
            
            
            
        }//End of VStack
            
            
        }//End of ZStack
        
    }//End of Body
    
    
    
    //Funciton to process data
        func loadCoronaData(completion: @escaping ([CoronaDataStructure]) -> ()) {
            
      
        
                //Declare URL Session
            guard let url = URL(string: "https://api.covid19api.com/total/country/\(self.coronStats.country)") else {
                    
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
