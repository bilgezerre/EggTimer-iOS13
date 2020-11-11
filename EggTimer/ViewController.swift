//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var secondsCounter = 60
    var totalTime = 0
    var secondsPassed = 0

    var player: AVAudioPlayer?
    var timer = Timer()
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard":7]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
 
//        switch hardness {
//        case "Soft":
//            print(softTime)
//        case "Medium":
//            print(mediumTime)
//        case "Hard":
//            print(hardTime)
//        default:
//            print("Error")
//        }

//        switch hardness {
//        case "Soft":
//            print(eggTimes[hardness]!)
//        case "Medium":
//            print(eggTimes[hardness]!)
//        case "Hard":
//            print(eggTimes[hardness]!)
//        default:
//            print("Error")
//        }

        timer.invalidate()
        progressView.progress = 0
        secondsPassed = 0
        let hardness = sender.currentTitle!
        secondsCounter = eggTimes[hardness]!
        totalTime = eggTimes[hardness]!
                
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateCounter() {
        //example functionality
        if secondsCounter > 0  && secondsPassed < totalTime{
            countdownLabel.text = String(secondsCounter)
            secondsCounter -= 1
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = Float(percentageProgress)
        }
        else{
            timer.invalidate()
            countdownLabel.text = String(secondsCounter)
            progressView.progress = 1.0
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    

}
