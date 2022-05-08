//
//  ViewController.swift
//  GuessFlag
//
//  Created by Denis Mordvinov on 01.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var askedQuestions = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco",
                    "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.masksToBounds = true
        button2.layer.masksToBounds = true
        button3.layer.masksToBounds = true

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion(action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        askedQuestions += 1
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = countries[correctAnswer].uppercased() + "  Your score is \(score)"

    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong answer. You have selected \(countries[sender.tag]) but that was \(countries[correctAnswer])"
            score -= 1

        }

        if askedQuestions == 10 {
            title = "your final score is \(score)"
            let ac = UIAlertController(title: "Final", message: title, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
            score = 0
        } else {
            let ac = UIAlertController(title: nil, message: title, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    
    @objc func showScore(){
        let alertVc = UIAlertController(title: "Your current score", message: String(score), preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alertVc, animated: true)
    }
    
}
