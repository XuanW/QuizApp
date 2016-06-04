//
//  ViewController.swift
//  QuizApp
//
//  Created by XuanWang on 6/3/16.
//  Copyright © 2016 XuanWang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionContent: UILabel!
    @IBOutlet weak var optionContent1: UIButton!
    @IBOutlet weak var optionContent2: UIButton!
    @IBOutlet weak var optionContent3: UIButton!
    @IBOutlet weak var optionContent4: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var next: UIButton!
    

    let questionsPerRound = 4
    var questionsAsked = 0
    
    var seconds = 0
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        next.hidden = true
        displayQuestion(getCurrentQuestion())
        startTimer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentQuestion() -> Question {
        let currentQuestion = randomizedQuestions[questionsAsked]
        questionsAsked += 1
        return currentQuestion
    }
    
    func displayQuestion(currentQuestion: Question) {
        questionContent.text = currentQuestion.questionContent
        optionContent1.setTitle(currentQuestion.options[0], forState: .Normal)
        optionContent2.setTitle(currentQuestion.options[1], forState: .Normal)
        optionContent3.setTitle(currentQuestion.options[2], forState: .Normal)
        
        switch currentQuestion.options.count {
        case 3: optionContent4.hidden = true
        case 4: optionContent4.setTitle(currentQuestion.options[3], forState: .Normal)
        default: break
        }
    }
    
    func startTimer() {
        seconds = 15
        timerLabel.text = "Time left: \(seconds)s"
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.subtractTime), userInfo: nil, repeats: true)
    }

    func subtractTime() {
        seconds -= 1
        timerLabel.text = "Time left: \(seconds)s"
        
        if(seconds == 0)  {
            timer.invalidate()
        }
    }
}
