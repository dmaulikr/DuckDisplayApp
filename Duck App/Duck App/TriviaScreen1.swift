//
//  TriviaScreen1.swift
//  Duck App
//
//  Created by Auburn University Senior Design on 3/29/17.
//  Copyright © 2017 Auburn University. All rights reserved.
//

import UIKit
import SQLite

var score: Int = 0

class TriviaScreen1: UIViewController {
    
    // MARK: Properties
    
    //timer to determine when the game is over
    var gameTimer: Timer!
    var dumbTimer: Timer!
    
    var chances = 5 //game will end when no more chances are available to prevent guess spamming
    var randNum: Int = Int(arc4random_uniform(44)) + 1//check this bound against rows in table
    var secondsRemaining = 120
    
    //variables for current trivia question handling
    var thisTriviaQuestion: TriviaQuestion?
    var thisQuestion: String = ""
    var thisAns1: String = ""
    var thisAns2: String = ""
    var thisAns3: String = ""
    var thisAns4: String = ""
    var thisCorrect: String = ""
    var thisPoints: Int = 0
    var thisPicture: String = ""
    var nextQuestion = 0
    var i = 0
    var randNumbers = [Int]()

    
    
    override func viewDidAppear(_ animated: Bool) {
        score = 0
        //load question and start timer
        getNextQuestion()
        gameTimer = Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(gameIsOver), userInfo: nil, repeats: false)
        dumbTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)

    }

    //displays score
    @IBOutlet weak var scoreLabel: UILabel!

    //outlet for the question text to be put into that textview
    @IBOutlet weak var questionText: UITextView!
    
    //outlet for the ImageView for pictures in questions
    @IBOutlet weak var questionImage: UIImageView!

    //outlet to show time remaining in the game
    @IBOutlet weak var timerOutlet: UITextView!
    
    //shows number of lives
    @IBOutlet weak var livesCounter: UILabel!
    
    override func viewDidLoad() {
        setBackground()
        livesCounter.text = "Lives: \(chances)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Duck-CamoBlur")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        
    }
    
    //Logic for each answer selected will be inside the action methods for the buttons
    //They will decide whether the asnwer is correct and change the buttons to reflect that
    //then score appropriately and call the getNextQuestion function
    
    @IBOutlet weak var buttonA: duckButton!
    @IBAction func answerAChosen(_ sender: Any) {
        if (thisAns1 != thisCorrect) {
            buttonA.backgroundColor = UIColor.red
            chances -= 1
            livesCounter.text = "Lives: \(chances)"
            if (chances == 0) {
                gameIsOver()
            }
        }
        else {
            buttonA.backgroundColor = UIColor.green
            score += thisPoints
        }
        
        disableButtons() //Disable buttons so user can't answer multiples times
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.getNextQuestion()
        })
    }
    

    @IBOutlet weak var buttonB: duckButton!
    @IBAction func answerBChosen(_ sender: Any) {
        if (thisAns2 != thisCorrect) {
            buttonB.backgroundColor = UIColor.red
            chances -= 1
            livesCounter.text = "Lives: \(chances)"
            if (chances == 0) {
                gameIsOver()
            }
        }
        else {
            buttonB.backgroundColor = UIColor.green
            score += thisPoints
        }

        disableButtons() //Disable buttons so user can't answer multiples times
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
           self.getNextQuestion()
        })
    }
    

    @IBOutlet weak var buttonC: duckButton!
    @IBAction func answerCChosen(_ sender: Any) {
        if (thisAns3 != thisCorrect) {
            buttonC.backgroundColor = UIColor.red
            chances -= 1
            livesCounter.text = "Lives: \(chances)"
            if (chances == 0) {
                gameIsOver()
            }
        }
        else {
            buttonC.backgroundColor = UIColor.green
            score += thisPoints
        }

        disableButtons() //Disable buttons so user can't answer multiples times
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.getNextQuestion()
        })
    }
    

    @IBOutlet weak var buttonD: duckButton!
    @IBAction func answerDChosen(_ sender: Any) {
        if (thisAns4 != thisCorrect) {
            buttonD.backgroundColor = UIColor.red
            chances -= 1
            livesCounter.text = "Lives: \(chances)"
            if (chances == 0) {
                gameIsOver()
            }
        }
        else {
            buttonD.backgroundColor = UIColor.green
            score += thisPoints
        }
        disableButtons() //Disable buttons so user can't answer multiples times
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.getNextQuestion()
        })
    }
    
    
    
    //gets the next question info from the database
    func getNextQuestion() {
        //reeable buttons
        enableButtons()
        //reset button colors
        buttonA.backgroundColor = UIColor.white
        buttonB.backgroundColor = UIColor.white
        buttonC.backgroundColor = UIColor.white
        buttonD.backgroundColor = UIColor.white
        
        getNewNumber()
        
        nextQuestion += 1
        
        let trivia_query = DuckDatabase.TriviaDataTable.triviaData.filter(DuckDatabase.TriviaDataTable.id == randNum)
        do {
            if let questionToBePlucked = try DuckDatabase.duckDB?.pluck(trivia_query) {
                
                thisQuestion = questionToBePlucked[DuckDatabase.TriviaDataTable.question]
                thisAns1 = questionToBePlucked[DuckDatabase.TriviaDataTable.ans1]
                thisAns2 = questionToBePlucked[DuckDatabase.TriviaDataTable.ans2]
                thisAns3 = questionToBePlucked[DuckDatabase.TriviaDataTable.ans3]
                thisAns4 = questionToBePlucked[DuckDatabase.TriviaDataTable.ans4]
                thisCorrect = questionToBePlucked[DuckDatabase.TriviaDataTable.correct]
                thisPoints = questionToBePlucked[DuckDatabase.TriviaDataTable.points]
                thisPicture = questionToBePlucked[DuckDatabase.TriviaDataTable.picture]
                
            }
        }
            
        catch {
            //stuff
        }
        
        
        thisTriviaQuestion = TriviaQuestion(question: thisQuestion, ans1: thisAns1, ans2: thisAns2, ans3: thisAns3, ans4: thisAns4, correct: thisCorrect, points: thisPoints, picture: thisPicture)!
        
        populateFields()
        
    }
    
    
    //puts the data intothe proper locations
    func populateFields() {
        //update score label
        scoreLabel.text = "Score: " + "\(score)"
        
        questionText.text = (thisTriviaQuestion?.question)! //set question text
        if (thisTriviaQuestion?.picture != nil) { //set image, if there is none hide imageview
            let realQuestionImage = UIImage(named: thisPicture)
            questionImage.image = realQuestionImage
        }
        else {
            questionImage.isHidden = true
        }

        buttonA.setTitle(thisAns1, for: .normal)
        buttonB.setTitle(thisAns2, for: .normal)
        buttonC.setTitle(thisAns3, for: .normal)
        buttonD.setTitle(thisAns4, for: .normal)
        
    }
    
    //updates timer outlet to game timer
    func update() {
        secondsRemaining -= 1
        timerOutlet.text = "\(secondsRemaining)"
    }
    
    
    //Selector method for game timer
    func gameIsOver() {
        gameTimer.invalidate()
        score += (chances * 10)
        
        //segue to the leaderboard screen
        self.performSegue(withIdentifier: "gameOver", sender: self)
        
    }
    func getNewNumber() {
        
        var a = 0
        randNum = Int(arc4random_uniform(44)) + 1//re-randomize to get a new question
        
        //Check to see if question has been asked
        while (a < randNumbers.count){
            if (randNum == randNumbers[a]){
                randNum = Int(arc4random_uniform(44)) + 1//re-randomize to get a new question
                a = 0
            }
            else{
                a = a + 1
            }
        }
        
        randNumbers.insert(randNum, at: i) //Store new questions in array of questions already asked
        
        i = i + 1
        if (i == 45){
            gameIsOver()
        }
    }
    //Function that disables buttons
    func disableButtons(){
       buttonA.isUserInteractionEnabled = false
       buttonB.isUserInteractionEnabled = false
       buttonC.isUserInteractionEnabled = false
       buttonD.isUserInteractionEnabled = false
    }
    
    //Function that enables buttons
    func enableButtons(){
        buttonA.isUserInteractionEnabled = true
        buttonB.isUserInteractionEnabled = true
        buttonC.isUserInteractionEnabled = true
        buttonD.isUserInteractionEnabled = true
    }
}
