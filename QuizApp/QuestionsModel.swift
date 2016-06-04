//
//  QuestionsModel.swift
//  QuizApp
//
//  Created by XuanWang on 6/3/16.
//  Copyright © 2016 XuanWang. All rights reserved.
//

import GameKit

class Question {
    var optionCount: Int = 4
    let questionContent: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let answer: String
    
    init(questionContent: String, optionCount: Int, option1: String, option2: String, option3: String, option4: String, answer: String) {
        self.questionContent = questionContent
        self.optionCount = optionCount
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.option4 = option4
        self.answer = answer
    }
}


// Create an array of instances of Question class and store them in struct

struct QuestionsModel {
    let questions = [
        Question(questionContent: "This was the only US President to serve more than two consecutive terms.", optionCount: 4, option1: "George Washington", option2: "Franklin D. Roosevelt", option3: "Woodrow Wilson", option4: "Andrew Jackson", answer: "Franklin D. Roosevelt"),
        Question(questionContent: "Which of the following countries has the most residents?", optionCount: 4, option1: "Nigeria", option2: "Russia", option3: "Iran", option4: "Vietnam", answer: "Nigeria"),
        Question(questionContent: "In what year war the United Nations founded?", optionCount: 4, option1: "1918", option2: "1919", option3: "1945", option4: "1954", answer: "1945"),
        Question(questionContent: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", optionCount: 4, option1: "Paris", option2: "Washington D.C.", option3: "New York City", option4: "Boston", answer: "New York City"),
        Question(questionContent: "Which nation produces the most oil?", optionCount: 3, option1: "Iran", option2: "Iraq", option3: "Canada", option4: "", answer: "Canada"),
        Question(questionContent: "Which country has most recently won consecutive World Cups in Soccer?", optionCount: 3, option1: "Italy", option2: "Brazil", option3: "Argetina", option4: "", answer: "Brazil"),
        Question(questionContent: "Which of the following rivers is longest?", optionCount: 4, option1: "Yangtze", option2: "Mississippi", option3: "Congo", option4: "Mekong", answer: "Mississippi"),
        Question(questionContent: "Which city is the oldest?", optionCount: 3, option1: "Mexico City", option2: "Cape Town", option3: "San Juan", option4: "", answer: "Mexico City"),
        Question(questionContent: "Which country was the first to allow women to vote in national elections?", optionCount: 3, option1: "United States", option2: "Poland", option3: "Sweden", option4: "", answer: "Poland"),
        Question(questionContent: "Which of these countries won the most medals in the 2012 Summer Games?", optionCount: 3, option1: "Germany", option2: "Japan", option3: "Great Britian", option4: "", answer: "Great Britian")
    ]
    
    func getRandomQuestionSequence(questionsPerRound: Int) -> [Question] {
        let randomSequence = getRandomSequence(questionsPerRound)
        var randomQuestionSequence: [Question] = []
        for i in 1...randomSequence.count {
            randomQuestionSequence.append(questions[randomSequence[i-1]])
        }
        
        return randomQuestionSequence
    }
}


//Helper method: Generate an array of non-repeating random number

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
