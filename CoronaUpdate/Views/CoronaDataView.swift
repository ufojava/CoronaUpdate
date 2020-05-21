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
                
                CoronaAPISession().loadCoronaData { country in
                    
                    self.countryStats = country
                    
                    
                    
                    
                }
                
                
                
        }//End of Appear
        
        
    }
    
}





//CoronaView Previews
struct CoronaView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CoronaView()
        
    }
    
}
