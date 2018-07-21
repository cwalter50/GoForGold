//
//  ViewController.swift
//  GoForGold
//
//  Created by Christopher Walter on 7/21/18.
//  Copyright © 2018 AssistStat. All rights reserved.
//
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var strikesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var takeTheMoneyButton: UIButton!
    @IBOutlet weak var restartGameButton: UIButton!
    @IBOutlet var boxes: [BoxButton]!
    
    // MARK: properties
    var boxValues = [0,0,0,0,0,0,0,0,0,0,100,200,300,400,500,600,700,800,900,1000]
    var score = 0
    var strikes = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpGame()
        
    }
    // This gets called everytime the focus changes for tvOS
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    {
        let item = context.nextFocusedView
        item?.layer.shadowOffset = CGSize(width: 20, height: 20)
        item?.layer.shadowColor = UIColor.black.cgColor
        item?.layer.shadowOpacity = 0.8
        item?.layer.shadowRadius = 15
        context.previouslyFocusedView?.layer.shadowOpacity = 0
    }
    
    func setUpGame()
    {
        assignValuesToBoxes()
        takeTheMoneyButton.isEnabled = true
    }
    
    func assignValuesToBoxes()
    {
        // make sure boxes.count matches boxValues.count!!!!
        
        // shuffle boxValues
        var shuffledArray: [Int] = []
        
        for _ in 0..<boxValues.count {
            let randIndex = Int(arc4random_uniform(UInt32(boxValues.count)))
            shuffledArray.append(boxValues[randIndex])
            boxValues.remove(at: randIndex)
        }
        boxValues = shuffledArray
        
        // place boxValues in for the value of the boxes
        for index in 0..<boxes.count {
            boxes[index].value = boxValues[index]
            boxes[index].isOpen = false
        }
    }
    
    @IBAction func boxSelectedTriggered(_ sender: BoxButton)
    {
        sender.isOpen = true
        score += sender.value
        
        if sender.value == 0 {
            strikes += 1
        }
        // Add Siri to project with text to speech
        let value = sender.value
        var statement = ""
        if value == 0 {
            statement = "Strike \(strikes)"
        } else {
            statement = "\(value) Shroot bucks"
        }
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: statement )
        utterance.rate = 0.5
        synthesizer.speak(utterance)
        
        updateGameState()
        
        
    }
    @IBAction func takeTheMoneyTriggered(_ sender: UIButton)
    {
        gameOver(title: "Congrats!!!", message: "You won $\(score)")
        
    }
    @IBAction func restartGameTriggered(_ sender: UIButton)
    {
        setUpGame()
        score = 0
        strikes = 0
        updateGameState()
        
    }
    
    func gameOver(title: String, message: String) {
        // send up congrats alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        // show all the buttons.  If they are open make the border RED else make the border gray
        for box in boxes {
            if box.isOpen == true {
                box.layer.borderColor = UIColor.green.cgColor
                box.layer.borderWidth = 10.0
            } else {
                box.isOpen = true
                box.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        takeTheMoneyButton.isEnabled = false
    }
    
    func updateGameState() {
        scoreLabel.text = "TOTAL: $\(score)"
        strikesLabel.text = "STRIKES: \(strikes)"
        
        if strikes >= 3 {
            scoreLabel.text = "$0:  You lost it all!"
            gameOver(title: "You LOST it ALL!!!", message: "The risk did not pay off!")
        }
    }
    
}
