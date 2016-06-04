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
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    let questions = QuestionsModel().getRandomizeQuestions()
    let questionsPerRound = 4
    var questionsAsked = 0
    var score = 0
    
    var seconds = 0
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayQuestion(questions[questionsAsked])
        nextButton.hidden = true
        feedbackLabel.hidden = true
        correctAnswer.hidden = true
//        displayQuestion(getCurrentQuestion())
        startTimer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // Set up countdown timer
    
    func startTimer() {
        seconds = 5
        timerLabel.text = "Time left: \(seconds)s"
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.subtractTime), userInfo: nil, repeats: true)
    }

    func subtractTime() {
        seconds -= 1
        timerLabel.text = "Time left: \(seconds)s"
        
        if(seconds == 0)  {
            showFeedback(result: false)
        }
    }
    
//    @IBAction func checkAnswer(sender: UIButton) {
//        let playerAnswer = sender.titleForState(.Normal)
//        if playerAnswer == getCurrentQuestion().answer {
//            score += 1
//        } else {
//            //
//        }
//    }
    
    func showFeedback(result right: Bool) {
        timer.invalidate()
        timerLabel.hidden = true
        
        let colorGreen = UIColor(red: 112.0/255.0, green: 193.0/255.0, blue: 179.0/255.0, alpha: 1.0)
        let colorRed = UIColor(red: 247.0/255.0, green: 119.0/255.0, blue: 111.0/255.0, alpha: 1.0)
        
        if right == true {
            feedbackLabel.text = "Correct!"
            feedbackLabel.textColor = colorGreen
            feedbackLabel.hidden = false
        } else if right == false {
            feedbackLabel.textColor = colorRed
            feedbackLabel.text = "Sorry, the correct answer is"
            correctAnswer.text = questions[questionsAsked].answer
            feedbackLabel.hidden = false
            correctAnswer.hidden = false
        }
    }
    
    
    
}
