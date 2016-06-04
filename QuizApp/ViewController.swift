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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let questionsPerRound = 4
        var questionsAsked = 0
        let questions = QuestionsModel()
        let randomizedQuestions = questions.getRandomizeQuestions()
        
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

        let currentQuestion = getCurrentQuestion()
        displayQuestion(currentQuestion)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
