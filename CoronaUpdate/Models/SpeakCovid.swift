//
//  SpeakCovid.swift
//  CoronaUpdate
//
//  Created by Ufuoma Okoro on 27/05/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//

//This file cover speech
import Foundation
import AVFoundation


//Function to take in a string and synthersiser GB to speak
func readText(word:String) {
    
    let utterance = AVSpeechUtterance(string: word)
    
    //Synthersizer - English GB
    utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
    
    //Rate - Speed for the voice
    utterance.rate = 0.5
    
    //Now pass to synthersiser
    let synthersiser = AVSpeechSynthesizer()
        synthersiser.speak(utterance)
    
        
}




