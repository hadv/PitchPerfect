//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Dang Viet Ha on 3/23/15.
//  Copyright (c) 2015 Dang Viet Ha. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlay: AVAudioPlayer!
    
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//            var filePathURL = NSURL.fileURLWithPath(filePath)
//            audioPlay = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
//            audioPlay.enableRate = true
//            
//        } else {
//            println("The file is empty")
//        }
        audioPlay = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlay.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func playSlowAudio(sender: UIButton) {
        // play sound very slooooowly......
        playAudioWithVariableRate(0.5)
    }
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableRate(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopPlayingSound(sender: UIButton) {
        audioPlay.stop()
        audioEngine.stop()
    }
    
    func playAudioWithVariableRate(rate: Float) {
        audioPlay.stop()
        audioPlay.rate = rate
        audioPlay.currentTime = 0.0
        audioPlay.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlay.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}
