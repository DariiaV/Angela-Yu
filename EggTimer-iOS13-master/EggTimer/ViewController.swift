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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer: Timer?
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let hardness = sender.currentTitle else {
            return
        }
        
        startCountdown(seconds: eggTimes[hardness]!)
        titleLabel.text = hardness
    }
    
    func startCountdown(seconds: Int) {
        let totalTime = Float(seconds)
        var secondsPassed: Float = 0
        timer?.invalidate()
        player?.stop()
        timer = Timer.scheduledTimer(withTimeInterval: 1,
                                     repeats: true) { _ in
            if secondsPassed < totalTime {
                self.progressView.progress = secondsPassed / totalTime
                secondsPassed += 1
            } else {
                self.progressView.progress = totalTime
                self.titleLabel.text = "Done!"
                self.timer?.invalidate()
                self.playSound()
            }
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
