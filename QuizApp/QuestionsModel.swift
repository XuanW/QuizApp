//
//  QuestionsModel.swift
//  QuizApp
//
//  Created by XuanWang on 6/3/16.
//  Copyright © 2016 XuanWang. All rights reserved.
//

import GameKit

class Question {
    let questionContent: String
    let options:[String]
    let answer: String
    
    init(questionContent: String, options: [String], answer: String) {
        self.questionContent = questionContent
        self.options = options
        self.answer = answer
    }
}


// Create an array of instances of Question class and store them in struct

struct QuestionsModel {
    let questions = [
        Question(questionContent: "This was the only US President to serve more than two consecutive terms.", options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: "Franklin D. Roosevelt"),
        Question(questionContent: "Which of the following countries has the most residents?", options:["Nigeria", "Russia", "Iran", "Vietnam"], answer: "Nigeria"),
        Question(questionContent: "In what year war the United Nations founded?", options: ["1918", "1919", "1945", "1954"], answer: "1945"),
        Question(questionContent: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options:["Paris", "Washington D.C.", "New York City", "Boston"], answer: "New York City"),
        Question(questionContent: "Which nation produces the most oil?", options:["Iran", "Iraq", "Canada"], answer: "Canada"),
        Question(questionContent: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Italy", "Brazil", "Argentina"], answer: "Brazil"),
        Question(questionContent: "Which of the following rivers is longest?", options: ["Yangtze", "Mississippi", "Congo", "Mekong"], answer: "Mississippi"),
        Question(questionContent: "Which city is the oldest?", options: ["Mexico City", "Cape Town", "San Juan"], answer: "Mexico City"),
        Question(questionContent: "Which country was the first to allow women to vote in national elections?", options: ["United States", "Poland", "Sweden"], answer: "Poland"),
        Question(questionContent: "Which of these countries won the most medals in the 2012 Summer Games?", options: ["Germany", "Japan", "Great Britain"], answer: "Great Britain")
    ]
    
    func getRandomizeQuestions() -> [Question] {
        let randomSequence = getRandomSequence(questions.count)
        var randomizedQuestions: [Question] = []
        for index in randomSequence {
            randomizedQuestions.append(questions[index])
        }
        return randomizedQuestions
    }
}


// Helper method: Generate an array of non-repeating random number

func getRandomSequence(count: Int) ->[Int] {
    var nums:[Int] = []
    for i in 1...count {
        nums.append(i-1)
    }
    
    var randomNum:[Int] = []
    while nums.count > 0 {
        let arrayKey = GKRandomSource.sharedRandom().nextIntWithUpperBound(nums.count)
        randomNum.append(nums[arrayKey])
        nums.removeAtIndex(arrayKey)
    }
    
    return randomNum
}

// Generate an instance of Questions model and randomize the quetsions
let questions = QuestionsModel()
let randomizedQuestions = questions.getRandomizeQuestions()
