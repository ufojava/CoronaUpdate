//
//  Tutorial.swift
//  CoronaUpdate
//
//  Created by Ufuoma Okoro on 31/05/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//

//Tutorial on how to use the application
import SwiftUI


struct Tutorial: View {
    
    @State private var showInstructionOneLandingPage = true
    @State private var showInstructionTwoClickInputCountry = false
    @State private var showInstructionThreeInputText = false
    @State private var showInstructionFourSelectReportType = false
    @State private var showInstructionFiveGetToggleButton = false
    @State private var showInstructionSixClearToggleButton = false
    @State private var showInstructionSevenHome = false
    @State private var showEndOfTutorial = false
    
    @State private var instructionsCounter = 0
    
    
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .top) {
                
                LinearGradient(gradient: Gradient(colors: [.blue,.white,.pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
        
                    VStack {
                        
                        
                                    Text("Instructions")
                                        .foregroundColor(Color.red)
                                        .font(.custom("Chalkboard", size: 25))
                        
                                        Button(action: {
                                            
                                            
                                            self.instructionsCounter += 1
                                            
                                            //Tutorial page two
                                            if self.instructionsCounter == 1 {
                                                
                                                self.showInstructionTwoClickInputCountry = true
                                                
                                                
                                                
                                            }
                                            
                                            //Tutorial page three
                                            if self.instructionsCounter == 2 {
                                                
                                                self.showInstructionThreeInputText = true
                                                
                                             
                                            }
                                            
                                            //Tutorila page four
                                            
                                            if self.instructionsCounter == 3 {
                                                
                                                self.showInstructionFourSelectReportType = true
                                            }
                                            
                                            //Tutorial to show report
                                            if self.instructionsCounter == 4 {
                                                
                                                self.showInstructionFiveGetToggleButton = true
                                            }
                                            
                                            //New Search
                                            if self.instructionsCounter == 5 {
                                                
                                                self.showInstructionSixClearToggleButton = true
                                            }
                                            
                                            //Back to home
                                            if self.instructionsCounter == 6 {
                                                
                                                self.showInstructionSevenHome = true
                                            }
                                            
                                            //End of Tutorial
                                            if self.instructionsCounter == 7 {
                                                
                                                self.showEndOfTutorial = true
                                            }
                                            
                                            //Reset Tutorial
                                            
                                            if self.instructionsCounter == 8 {
                                                
                                                //Rest all Tutoroal pages to false
                                                self.showInstructionTwoClickInputCountry = false
                                                self.showInstructionThreeInputText = false
                                                self.showInstructionFourSelectReportType = false
                                                self.showInstructionFiveGetToggleButton = false
                                                self.showInstructionSixClearToggleButton = false
                                                self.showInstructionSevenHome = false
                                                self.showEndOfTutorial = false
                                                
                                                self.instructionsCounter = 0
                                                
                                            }
                                                
                                        }) {
                                            
                                  
                                            
                                            Image(systemName:"play")
                                                .resizable()
                                                .frame(width:40,height: 40)
                                                .foregroundColor(Color.gray)
                                            
                                                
                                                                
                                        }
                        Spacer().frame(height:50)
                    
                        Group {
                            if self.showInstructionOneLandingPage && self.instructionsCounter == 0 {
                                
                                VStack {
                                
                                    TextFrame(inText: "1. Input Country")
                                    
                                    PictureFrame(image: "InsertCountry")
                                    
                                }
                                .transition(.slide)
                                .animation(.default)
                            }
                        
                            if self.showInstructionTwoClickInputCountry && self.instructionsCounter == 1 {
                                
                                VStack {
                                
                                TextFrame(inText: "2.Type Country")
                                    
                                PictureFrame(image: "TypeInBox")
                                    
                                }
                                
                                .transition(.slide)
                                .animation(.default)
                            }
                        
                            if self.showInstructionThreeInputText && self.instructionsCounter == 2 {
                                
                                
                                VStack {
                                    
                                    
                                    TextFrame(inText: "3. Country Revealed ")
                                    
                                    PictureFrame(image: "CountriesRevealed")
                                    
                                    
                                }
                                
                                .transition(.slide)
                                .animation(.default)
                            }
                        
                        }//End of Group
                        
                        Group {
                            if self.showInstructionFourSelectReportType && self.instructionsCounter == 3 {
                                
                                
                                VStack {
                                    
                                    
                                    TextFrame(inText: "4. Complete as shown")
                                    
                                    PictureFrame(image: "InputFormDetails")
                                    
                                    
                                    
                                }
                                
                                .transition(.slide)
                                .animation(.default)
                                
                            }
                        
                            if self.showInstructionFiveGetToggleButton && self.instructionsCounter == 4 {
                                
                                VStack {
                                
                                
                                    TextFrame(inText: "5. Summary Report ")
                                    
                                    PictureFrame(image: "SummaryReport")
                                    
                                }
                                
                                .transition(.slide)
                                .animation(.default)
                            }
                        
                            if self.showInstructionSixClearToggleButton && self.instructionsCounter == 5 {
                                
                                VStack {
                                
                                    TextFrame(inText: "6. New Search")
                                    
                                    PictureFrame(image: "NewSearch")
                                        
                                }
                                
                                .transition(.slide)
                                .animation(.default)
                            }
                            
                        }//End of Group
                        
                        Group {
                        
                            if self.showInstructionSevenHome && self.instructionsCounter == 6 {
                                
                                VStack {
                                    
                                    TextFrame(inText: "7. Home Page")
                                    
                                    PictureFrame(image: "BackToHome")
                                    
                                }
                                
                                .transition(.slide)
                                .animation(.default)
                            }
                        
                        
                        
                        
                            if self.showEndOfTutorial && self.instructionsCounter == 7 {
                                
                                VStack {
                                
                                    Text("End of Tutorial")
                                        .foregroundColor(Color.red)
                                        .font(.custom("Chalkboard", size: 25))
                                    
                                    Spacer().frame(height:25)
                                    
                                    Text("Click 🏚 to exit ▶️ repeat tutorial")
                                        .foregroundColor(Color.blue)
                                        .font(.custom("Chalkboard", size: 20))
                                    
                                    
                                
                                }
                            }
                        
                            
                            
                        }//End of Group
                
                
                
                    
                    }//End of VStack
                
            
         
            
            
            
            }
            
        }
        
    
}
    
    
}



//Preview for Tutorial
struct Tutorial_Preview:    PreviewProvider {
    
    static var previews: some View {
        
        Tutorial()
        
    }
    
}

struct PictureFrame: View {
    
    var image = ""
    
    
    var body: some View {
        
    Image(image)
    .resizable()
    .frame(width:280,height: 300)
    .scaledToFill()
    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
        

        
    }
}

struct TextFrame: View {
    
    var inText = ""
    
    var body: some View {
        
        HStack {
            
            Text(inText)

                .foregroundColor(Color.gray)
            
            Spacer().frame(width:150)
            
            
        }
        
        
    }
    
}
