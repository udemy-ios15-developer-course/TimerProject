//
//  ViewController.swift
//  TimerProject
//
//  Created by Chris Hand on 8/14/22.
//

import UIKit

class ViewController: UIViewController {
    private var timer = Timer()
    private var count = 10
    private var runState : RunState = .ready
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonState()
    }
    
    
    private func setButtonState() {
        switch runState {
        case .ready:
            topButton.setTitle("Start \(count)", for: .normal)
            bottomButton.setTitle("increment + 10", for: .normal)
         
        case .running:
            topButton.setTitle("pause: \(count)", for: .normal)
            bottomButton.setTitle("increment + 10", for: .normal)
            
        case .paused:
            topButton.setTitle("resume: \(count)", for: .normal)
            bottomButton.setTitle("decrement - 10", for: .normal)
            
        case .completed:
            topButton.setTitle("completed!", for: .normal)
            bottomButton.setTitle("reset", for: .normal)
            topButton.isEnabled = false
        }
    }
    
    
    @objc
    private func timerTicked() {
        count -= 1
        print("tick")
        if (count <= 0) {
            timer.invalidate()
            runState = .completed
        }
        
        setButtonState()
    }
    
    @IBAction func topButtonClicked(_ sender: Any) {
        switch runState {
        case .ready:
            runState = .running
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTicked), userInfo: nil, repeats: true)
            
        case .running:
            timer.invalidate()
            runState = .paused
            
        case .paused:
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTicked), userInfo: nil, repeats: true)
            runState = .running
            
        case .completed:
            print("Should never get to topButtonClicked.completed")
        }
        
        setButtonState()
    }
    
    @IBAction func bottomButtonClicked(_ sender: Any) {
        switch runState {
        case .ready:
            count += 10
            
        case .running:
            count += 10
            
        case .paused:
            count -= 10
            if (count < 0) {
                count = 0
            }
            
        case .completed:
            count = 10
            topButton.isEnabled = true
            runState = .ready
        }
        
        setButtonState()
    }
    
    private enum RunState {
        case ready
        case running
        case paused
        case completed
    }
}

