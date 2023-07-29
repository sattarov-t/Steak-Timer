//
//  ViewController.swift
//  Steak Timer
//
//  Created by Тимур on 29.07.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var doneStatus: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var timer = Timer()
    var player: AVAudioPlayer!
    var deagre = ["Rare": 3, "Medium": 5, "Well": 7]
    var totalTime = 0
    var passedSeconds = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.restorationIdentifier!
        totalTime = deagre[hardness]!
        
        progressBar.progress = 0.0
        passedSeconds = 0
        doneStatus.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if passedSeconds < totalTime {
            passedSeconds += 1
            progressBar.progress = Float(passedSeconds) / Float(totalTime)

        } else {
            timer.invalidate()
            doneStatus.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
}

