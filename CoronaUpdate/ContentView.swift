//
//  ContentView.swift
//  CoronaUpdate
//
//  Created by Ufuoma Okoro on 21/05/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
   
    

    
    var body: some View {
        
        NavigationView {
                
            ZStack(alignment: .top) {
            
                LinearGradient(gradient: Gradient(colors: [.blue,.white,.pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                
                
                VStack {
                    
                    Spacer().frame(height:50)
                    
                    Text("Covid-19 Country Data")
                        .foregroundColor(Color.pink)
                        .font(.custom("Chalkboard", size: 25))
                    Spacer().frame(height:50)
                    
                    
                        //Insert Flower Image
                    HStack {
                        Spacer().frame(width:50)
                        Image("FrontImage")
                            .resizable()
                            .frame(width:200,height: 200)
                            .scaledToFill()
                    }
                    
                    Spacer().frame(height:100)
                    
                        NavigationLink(destination: CoronaView()) {
                            
                            
                            Text("Begin")
                                .foregroundColor(Color.blue)
                                .font(.custom("Chalkboard", size: 20))
                                
                                .frame(width:120,height: 30)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                              
                                
                        }
                    Spacer()
                    
                    NavigationLink(destination: Tutorial()) {
                        
                        Text("Help 🛠")
                        
                    }
                    
                    Text("Developed by: UfoSoft").font(.footnote)
                        .foregroundColor(Color.init(red: 0.2, green: 0.6, blue: 0.4))
                    Text("Web: https://ufookoro.wixsite.com/website").font(.footnote)
                    .foregroundColor(Color.init(red: 0.2, green: 0.6, blue: 0.4))
                    
                }
                Spacer()
                
                    
        
        //Navigation Bar Title
        .navigationBarTitle(Text("Home 🏚" ))
       
    }//End of ZStack
        }
}
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
