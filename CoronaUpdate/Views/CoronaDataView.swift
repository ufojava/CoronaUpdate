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
    

   
    
    var body: some View {
        
        CoronaAPIData()
        
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
    
    
    //Country Input
    @State private var inSearchCountry = ""
    @State private var selectedRow = ""
    
    //Report Selection Input
    @State private var reportType = ["Summary", "Detailed"]
    @State private var selectedType = 0
    
    
    //Check if Insearch is blank
    @State private var inCountryStatus = false
    @State private var runCoronaData = false
    
    //Show Input Page Holding Image
    @State private var showIntroImage = false
    @State private var showIntroTextOne = false
    @State private var showIntroTextTwo = false
    

    //Country Summary
    @State private var totaCountryName = ""
    @State private var totalConfirmedCases = 0
    @State private var totalDeaths = 0
    @State private var totalRecovered = 0
    @State private var totalActiveCases = 0
    @State private var totalDate = ""
    
    //Loading Status
    @State private var showLoading = false
    //@State private var showNewSearchInstruction = false
    @State private var newSearchMessage = ""
    

    
    
    //Function to get countryname
    func getCountryName() -> some View {
        
        
        
        
         
        
        
   return     VStack {
                   
            
                  
                        VStack {
                            
                        
                                
                                    TextField("Enter Country", text: $inSearchCountry)
                                        .frame(width:370,height: 30)
                                                        .autocapitalization(.none)
                                                        .disableAutocorrection(true)
                                                        .padding()
                                        
                             
                            //Picker for report type
                            Picker(selection: $selectedType, label: Text("Type")) {
                                
                                ForEach(0..<reportType.count) {
                                    
                                    Text(self.reportType[$0])
                                    
                                }
                                
                            }.pickerStyle(SegmentedPickerStyle())
                                .frame(height:50)
                            
                    
            
                            
                            
                    }//End of VStack
                    
 
                        
            VStack(alignment: .leading) {
                       
                       List {
                       
                       
                               ForEach(countries.jsonFileData.sorted(by: {$0.Slug < $1.Slug}).filter {$0.Slug .contains(self.inSearchCountry)},id: \.ISO2) { country in
                                   
                                   Text(country.Slug)
                    
                                       .onTapGesture {
                                           self.selectedRow = country.Slug
                                        
                                        
                                                             
                                   }
                                       
                   
                                   
                               }
                       
                       }//End of List
                       
                       
            }.padding()
           
                   

               
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
    
    
    
    
    //Function to pull summary infomation
    func getSummaryReport(inCountry:String) -> some View {
        
        
        
        return  VStack {
            
        
            Text("Total \(self.totaCountryName) Figures")
                .font(.custom("Cochin", size: 25))
                .foregroundColor(Color.yellow)
            
            Spacer().frame(height:50)
        
            Group {
                HStack {
                    Capsule()
                        .frame(width:50,height: 5)
                        .foregroundColor(Color.blue)
                    
                    Capsule()
                    .frame(width:50,height: 5)
                    .foregroundColor(Color.green)
                    
                    Capsule()
                    .frame(width:50,height: 5)
                    .foregroundColor(Color.red)
                    
                    Capsule()
                    .frame(width:50,height: 5)
                    .foregroundColor(Color.purple)
                    
                    Capsule()
                    .frame(width:50,height: 5)
                    .foregroundColor(Color.orange)
                }
                
                Spacer().frame(height:20)
                
                Text("Total Confirmed: \(self.totalConfirmedCases)")
                Text("Total Cases: \(self.totalActiveCases)")
                Text("Total Deaths:\(self.totalDeaths)").foregroundColor(Color.red)
                Text("Total Recovered: \(self.totalRecovered)").foregroundColor(Color.green)
                Text("Date: \(self.totalDate)")
            
            Spacer().frame(height:20)
            }
            
            VStack {
                
                
                HStack {
                    Capsule()
                        .frame(width:50,height: 5)
                        .foregroundColor(Color.blue)
                    
                    Capsule()
                    .frame(width:50,height: 5)
                    .foregroundColor(Color.green)
                    
                    Capsule()
                    .frame(width:50,height: 5)
                    .foregroundColor(Color.red)
                    
                    Capsule()
                    .frame(width:50,height: 5)
                    .foregroundColor(Color.purple)
                    
                    Capsule()
                    .frame(width:50,height: 5)
                    .foregroundColor(Color.orange)
                }
                
                
                
                
            }//End of VStack
            
            Spacer().frame(height:90)
            
            VStack {
                
                Text("Credits:")
                
                Text("Data Provided By Covid19 API")
                Text("http://covid19api.com")
                Text("API: https://api.covid19api.com/total/country/")
                
                
            }
            .font(.system(.footnote))
            
            Spacer()
                
        }//End HStack
            
            .onAppear() {
                
               
        
                self.coronStats.country = inCountry
            
                
                self.loadCoronaData { country in
                    
                    self.countryStats = country
                    
                    self.totaCountryName = self.countryStats.last?.Country ?? "nil"
                    self.totalConfirmedCases = self.countryStats.last?.Confirmed ?? 0
                    self.totalDeaths = self.countryStats.last?.Deaths ?? 0
                    self.totalRecovered = self.countryStats.last?.Recovered ?? 0
                    self.totalActiveCases = self.countryStats.last?.Active ?? 0
                    self.totalDate = self.countryStats.last?.Date ?? "nil"
                    
                    
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
            /*
            //Introduction - Speech Tutorial
                .onAppear() {
                    readText(word: "Welcome to Covid Global Statistics")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        
                        readText(word: "Press Input Country. Type a few letter to reveal the country")
                        
                        
                    }
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                           
                           readText(word: "Press your selection to confirm country choice")
                           
                           
                       }
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 14) {
                                        
                        readText(word: "Now make report type. Summary or Detailed")
                        
                        
                    }
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 18) {
                                        
                        readText(word: "Now press Get Data to reveal query results.")
                        
                        
                    }
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 22) {
                                        
                        readText(word: "Press get Clear Data to make another selection.")
                        
                        
                    }
                                       
                    
                    
            }//End of OnAppear
            
           */
        
        
        VStack {
            
            
            
                        HStack {
                 
                        
                                Button(action: {
                                    
                                    
                                    self.newSearchMessage = "Loading"
                                    if self.showLoading {
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        
                                        self.showLoading.toggle()
                                        }
                                    }
                                    
                                   
                                    
                                    
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
                                
                                if self.runCoronaData == false && self.selectedRow != "" {
                                    
                                    withAnimation {
                                    
                                        self.showLoading.toggle()
                                        self.newSearchMessage = "Click Input Country"
                                    }
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
                .foregroundColor(Color.purple)
           
            
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
                
                if self.showLoading {
                    
                    VStack {
                        
                        Text("\(self.newSearchMessage)")
                                .foregroundColor(Color.red)
                                .font(.custom("Chalkboard", size: 25))
                                
                                Spacer().frame(height:20)
                            
                            Image("Loading")
                                .resizable()
                                .frame(width:90,height: 180)
                                .scaledToFill()
                                
                    }
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
            
            //Show Country Detailed
            
            if self.runCoronaData && reportType[selectedType] == "Detailed" {
                                           
               getCountryData(inCountry: "\(self.selectedRow)")
                
                //Summary Test
               
            } else if runCoronaData && reportType[selectedType] == "Summary" {
                
                getSummaryReport(inCountry: "\(self.selectedRow)")
                
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
   
    @State private var lastElement = ["One","Two","Three","Four","Five"]
    @State private var showElement = false
    
    
    //Function to five me the last value
    func lastWord() -> some View {
        
        
        let lastValueinArray = lastElement.last
        
        //print(lastValueinArray as Any)
        
        return Text("\(lastValueinArray ?? "nil")")
        
        
    }
    
    
    
    var body: some View {
        
        VStack {
            
           
            Text("Place Holder")
            
                .onAppear() {
                    
                    self.showElement = true
                    
                    //self.lastWord()
                    
            }
            
            if self.showElement {
                
                self.lastWord()
                
            }
            
            
        
        
        
        }
        
    }
    
}
