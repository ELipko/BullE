//
//  ViewController.swift
//  BullsEye
//
//  Created by Yauheni Lipko on 1/8/19.
//  Copyright © 2019 Yauheni Lipko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    // - Property
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        configureSlider()
    }
    
    // - Game Configurator
    func configureSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func startNewRound() {
        updateRoundData()
        updateLabels()
    }
    
    func updateRoundData() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame () {
        updateGameData()
        startNewRound()
    }
    
    func updateGameData() {
        score = 0
        round = 0
    }
    
    
    // - Action
    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        let message = "You score \(points) points"
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not ever close ..."
        }
        score += points
        
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction (title: "OK", style: .default,
                                    handler: { action in
                                        self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func newGame () {
        startNewGame()
    }
    
}

/*var difference: Int
 if currentValue > targetValue {
 difference = currentValue - targetValue
 } else if targetValue > currentValue {
 difference = targetValue - currentValue
 } else {
 difference = 0
 }*/
/*var difference = currentValue - targetValue
 if difference < 0 {
 difference *= -1
 }*/
