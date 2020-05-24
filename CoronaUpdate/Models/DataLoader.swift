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
    
    //From JSON File
    @Published var name = ""
    @Published var code = ""
    
    
    
}



//Data Structure from API
struct CoronaDataStructure: Codable {
    
   
    var Country: String
    var CountryCode: String
    var Confirmed: Int
    var Deaths: Int
    var Recovered: Int
    var Active: Int
    var Date:   String
    
    
    
}//End of CoronaDataStructure Template


//Data structure from JSON File
struct CountryJSONStructure: Codable {
    
    var name: String
    var code: String
    
}

//Class to retreive data from JSON Filef
public class JsonDataLoader: ObservableObject {
    
    @Published var jsonFileData = [CountryJSONStructure]()
    
    //Now to initilise
    init() {
        decodeJSONFile()
    }
    
 
    
    
    
 //Function to decode JSON File
    func decodeJSONFile() {
        
        //Flle using let to prevent crashes if the file exist
        if let fileLocation = Bundle.main.url(forResource: "CountryFile", withExtension: "json") {
            
            //Do try catch
            
            do {
                
                
             //Define Data
             let data = try Data(contentsOf: fileLocation)
                
                
              //Define JSON Decoder
                let jsonDecoder = JSONDecoder()
                
                //Decode JSON Data
                let dataFromJSONFile = try jsonDecoder.decode([CountryJSONStructure].self, from: data)
                
                
                //Asynchronsly load the JSON File
                DispatchQueue.main.async {
                    self.jsonFileData = dataFromJSONFile
                }
                
                
            } catch {
                
                print("file not found")
                
                
            }
            
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    
}





