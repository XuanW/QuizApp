//
//  ViewController.swift
//  QuizApp
//
//  Created by XuanWang on 6/3/16.
//  Copyright © 2016 XuanWang. All rights reserved.
//

import UIKit
import AudioToolbox

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
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var resultSubtitle: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    var btnGroup : [UIButton] = [] // Putting all the option buttons into an array for easier group manipulation in later methods
    
    var correctAnswerSound: SystemSoundID = 0
    var wrongAnswerSound: SystemSoundID = 0
    var winGameSound: SystemSoundID = 0
    var loseGameSound: SystemSoundID = 0
    
    var questions = QuestionsModel().getRandomizeQuestions()
    let questionsPerGame = 4
    var questionsAsked = 0 // Acting like an index for the questions array when smaller than questionsPerGame
    var score = 0
    
    var seconds = 0
    var timer = NSTimer()
    
    let colorGreen = UIColor(red: 112.0/255.0, green: 193.0/255.0, blue: 179.0/255.0, alpha: 1.0)
    let colorRed = UIColor(red: 247.0/255.0, green: 119.0/255.0, blue: 111.0/255.0, alpha: 1.0)
    let colorText = UIColor(red: 80.0/255.0, green: 81.0/255.0, blue: 79.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayQuestion(questions[questionsAsked])
        startTimer()
        
        // Initialize btnGroup
        btnGroup.append(optionContent1)
        btnGroup.append(optionContent2)
        btnGroup.append(optionContent3)
        btnGroup.append(optionContent4)
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
        case 4: optionContent4.hidden = false;
                optionContent4.setTitle(currentQuestion.options[3], forState: .Normal)
        default: break
        }
    }
    
    // Set up countdown timer
    
    func startTimer() {
        seconds = 15
        timerLabel.hidden = false
        timerLabel.text = "Time left: \(seconds)s"
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.subtractTime), userInfo: nil, repeats: true)
    }

    func subtractTime() {
        seconds -= 1
        timerLabel.text = "Time left: \(seconds)s"
        
        if(seconds == 0)  {
            switchButtonState()
            showFeedback(result: false)
            loadWrongAnswerSound()
            playWrongAnswerSound()
            questionsAsked += 1
        }
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Disable buttons before the next question shows
        switchButtonState()
        
        // Highlight the button player selected
        sender.setTitleColor(colorText, forState: .Disabled)
        
        let playerAnswer = sender.titleForState(.Normal)
        if playerAnswer == questions[questionsAsked].answer {
            score += 1
            showFeedback(result: true)
            loadCorrectAnswerSound()
            playCorrectAnswerSound()
        } else {
            showFeedback(result: false)
            loadWrongAnswerSound()
            playWrongAnswerSound()
        }
        questionsAsked += 1

    }
    
    func showFeedback(result right: Bool) {
        timer.invalidate()
        timerLabel.hidden = true
        nextButton.hidden = false
        
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
    
    @IBAction func nextRound() {
        if questionsAsked == questionsPerGame {
            // Game is over
            displayScore()
        }
        else {
            // Show next question
            switchButtonState()
            resetDisabledStyle()
            displayQuestion(questions[questionsAsked])
            feedbackLabel.hidden = true
            correctAnswer.hidden = true
            startTimer()
        }
    }
    
    @IBAction func playAgain() {
        questions = QuestionsModel().getRandomizeQuestions()
        switchScreen(isResultScreen: false)
        switchButtonState()
        resetDisabledStyle()
        questionsAsked = 0
        score = 0
        displayQuestion(questions[questionsAsked])
        startTimer()
    }
    
    func displayScore() {
        
        if (Double(score) / Double(questionsPerGame) >= 0.6) {
            resultTitle.text = "Good job!"
            view.backgroundColor = colorGreen
            loadWinGameSound()
            playWinGameSound()
        } else {
            resultTitle.text = "Try again..."
            view.backgroundColor = colorRed
            loadLoseGameSound()
            playLoseGameSound()
        }
        
        switchScreen(isResultScreen: true)
        resultSubtitle.text = "You got \(score) out of \(questionsPerGame) questions right"
    }
    
    
    
    // Helper methods
    
    // Swtich option buttons between enabled and disabled states
    func switchButtonState() {
        for btn in btnGroup {
            if btn.enabled == true {
                btn.enabled = false
            } else { btn.enabled = true}
        }
    }
    
    // Reset the disabled button style so they don't remain highlighted from previous question
    func resetDisabledStyle() {
        for btn in btnGroup {
            btn.setTitleColor(colorText.colorWithAlphaComponent(0.2), forState: .Disabled)
        }
    }
    
    // Switch interface between question and result
    func switchScreen(isResultScreen screenState: Bool) {
        if screenState {
            questionContent.hidden = true
            optionContent1.hidden = true
            optionContent2.hidden = true
            optionContent3.hidden = true
            optionContent4.hidden = true
            feedbackLabel.hidden =  true
            correctAnswer.hidden = true
            nextButton.hidden = true
            resultTitle.hidden = false
            resultSubtitle.hidden = false
            playAgainButton.hidden = false
        } else {
            questionContent.hidden = false
            optionContent1.hidden = false
            optionContent2.hidden = false
            optionContent3.hidden = false
            optionContent4.hidden = false
            feedbackLabel.hidden =  true
            correctAnswer.hidden = true
            nextButton.hidden = true
            resultTitle.hidden = true
            resultSubtitle.hidden = true
            playAgainButton.hidden = true
            view.backgroundColor = colorText
        }
    }
    
    // Load and play sound when answer is correct
    func loadCorrectAnswerSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("right", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &correctAnswerSound)
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctAnswerSound)
    }
    
    // Load and play sound when answer is wrong
    func loadWrongAnswerSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("wrong", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &wrongAnswerSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongAnswerSound)
    }
    
    // Load and play sound when player wins the game
    func loadWinGameSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("win", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &winGameSound)
    }
    
    func playWinGameSound() {
        AudioServicesPlaySystemSound(winGameSound)
    }
    
    // Load and play sound when player loses the game
    func loadLoseGameSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("lose", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &loseGameSound)
    }
    
    func playLoseGameSound() {
        AudioServicesPlaySystemSound(loseGameSound)
    }
    
}
