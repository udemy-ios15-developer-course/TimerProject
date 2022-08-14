//
//  ViewController.swift
//  TimerProject
//
//  Created by Chris Hand on 8/14/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counter: UILabel!
    
    var timer = Timer()
    var count = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter.text = "Counter: \(count)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTicked), userInfo: nil, repeats: true)
    }
    
    @objc
    private func timerTicked() {
        count -= 1
        counter.text = "Counter: \(count)"
        
        if (count == 0) {
            counter.text = "Times up!"
            timer.invalidate()
        }
    }
    
    @IBAction func startClicked(_ sender: Any) {
    
    }
}

