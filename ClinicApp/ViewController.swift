//
//  ViewController.swift
//  ClinicApp
//
//  Created by Daniel Ortiz on 6/30/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        firstVisitButton.layer.cornerRadius = 10
//        followUpVisitButton.layer.cornerRadius = 10
//        overTheCounterMedsButton.layer.cornerRadius = 10
//        personalIllnessButton.layer.cornerRadius = 10
        
//        let vc = UIHostingController(rootView: LoadingScreen())
        present(vc, animated: true)

    }
    
    let vc = UIHostingController(rootView: LoadingScreen())
    
    
    
    //Mark: Variables
    
    @IBOutlet var firstVisitButton: UIButton!
    
  
    @IBOutlet var followUpVisitButton: UIButton!
    
    
    @IBOutlet var overTheCounterMedsButton: UIButton!
    
    
    @IBOutlet var personalIllnessButton: UIButton!
    
    var covidTestArray = [String]()
    
//    var keyInput = "" {
//        didSet {
//            print("Your Key Input is now \(keyInput)")
//        }
//    }
//
//
//    @IBAction func firstVisitTapped(_ sender: Any) {
//
//        print("hello you are \(keyInput) and are here for your first visit")
//
//        covidTestArray.append(keyInput)
//        print(covidTestArray)
//
//    }
//
//    @IBAction func followUpVisitTapped(_ sender: Any) {
//
//        print("hello you are \(keyInput) and are here for your follow up visit")
//    }
//
//    @IBAction func overTheCounterMedsTapped(_ sender: Any) {
//
//        print("hello you are \(keyInput) and are here for some over the counter medications")
//    }
//
//    @IBAction func personalIllnessTapped(_ sender: Any) {
//
//
//        print("hello you are \(keyInput)and are here for a personal illness")
//    }
//
//
//    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
//        guard let key = presses.first?.key else { return }
//
////        print(keyInput.count)
//
//        if keyInput.count == 0 {
//            keyInput.append(contentsOf: key.characters)
//        } else if keyInput.count == 7 {
//
//            keyInput = ""
//            keyInput.append(contentsOf: key.characters)
//        } else {
//            keyInput.append(contentsOf: key.characters)
//        }
//
////        print(keyInput)
//
//
//
//
//    }
//
//
    
}
