//
//  AudioPlayer.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 16.04.2021.
//

import Foundation
import AVFoundation




class AudioPlayer{
    
    
    var player:AVAudioPlayer!
    
    
    func setupPlayer(){
        
        guard let soundURL = Bundle.main.url(forResource: "Smash Mouth - All Star", withExtension: "mp3") else { return }
        
        do {
            
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: soundURL)
            player.numberOfLoops = -1
            player.prepareToPlay()
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func playPausePlayer(){
        
        if player.isPlaying{
            pause()
        }else{
            play()
        }
    }
    
    func play(){
        player.play()
    }
    
    func pause(){
        player.pause()
    }
    
    func stop(){
        player.stop()
    }
    
    
}
