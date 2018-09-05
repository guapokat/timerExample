//
//  ViewController.swift
//  timerExample
//
//  Created by Virgil Martinez on 9/5/18.
//  Copyright © 2018 Virgil Martinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - VARIABLES
    var seconds = 60 //will hold a starting value of seconds..could be anything above 0
    var timer = Timer()
    var isTimerRunning = false //make sure only one timer created at a time
    var resumeTapped = false //has pause button been tapped before?
    
    //MARK: - OUTLETS
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var startButton: UIButton!
    
    //MARK: - ACTIONS
    @IBAction func startPressed(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    
    @IBAction func pausedPressed(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.pauseButton.setTitle("Resume", for: .normal)
            self.resumeTapped = true
        } else {
            runTimer()
            self.pauseButton.setTitle("Pause", for: .normal)
            self.resumeTapped = false
        }
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        timer.invalidate()
        seconds = 60
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        pauseButton.setTitle("Pause", for: .normal)
    }
    
    //MARK: - LIFE CYCLE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
    }
    
    //MARK: - CUSTOM FUNCTIONS
    func runTimer() {
        //selector is method being called
        //interval in seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //can send alert here
        } else {
            seconds -= 1 //decrement
            timerLabel.text = timeString(time: TimeInterval(seconds)) //updates label
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 360
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}

