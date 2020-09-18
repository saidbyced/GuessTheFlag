//
//  ViewController.swift
//  Guess the Flag
//
//  Created by Chris Eadie on 18/09/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var questionsCount = 0
    var correctAnswer = 0
    var correctCountry: String {
        if countries[correctAnswer].count < 3 {
            return "the \(countries[correctAnswer].uppercased())"
        } else {
            return countries[correctAnswer].capitalized
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += [
            "estonia",
            "france",
            "germany",
            "ireland",
            "italy",
            "monaco",
            "nigeria",
            "poland",
            "russia",
            "spain",
            "uk",
            "us"
        ]
        
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(_ action: UIAlertAction! = nil) {
        questionsCount += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        title = correctCountry.capitalized
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        var selectedCountry: String {
            if countries[sender.tag].count < 3 {
                return "the \(countries[sender.tag].uppercased())"
            } else {
                return countries[sender.tag].capitalized
            }
        }
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Well done!\nYour score is now \(score)."
        } else {
            title = "Wrong"
            score -= 1
            message = "You selected the flag of \(selectedCountry).\nYour score is now \(score)."
        }
        
        if questionsCount < 10 {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
            
            title = "Congrats!"
            message = "You've completed this trial of 'Guess the Flag'!\nYour final score is \(score)!"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            present(ac, animated: true)
        }
    }
}

