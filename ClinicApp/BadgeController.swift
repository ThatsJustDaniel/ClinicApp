//
//  SwiftUIViewViewController.swift
//  ClinicApp
//
//  Created by Daniel Ortiz on 8/10/22.
//

import UIKit
import SwiftUI

class BadgeController: UIViewController {
    
    let persistenceController = PersistenceController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTimer()
         
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view is here again! ")
    }
    
    var goToView = false
    
    var keyInput = "" {
        didSet {
            
            print("Your Key Input is now \(keyInput)")
                     
            
        }
    }
    
    
    @IBSegueAction func SwiftUI(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: LoadingScreen())
    }
    
    
    
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard let key = presses.first?.key else { return }
        
        
        print("your key input count is \(keyInput.count)")
        
        if self.goToView == true {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                
                print("1/2 second has passed and the keyInput count is \(self.keyInput.count)")
                
                print("lets go the view controller")
    //            let vc = UIHostingController(rootView: MainScreen(keyInput: keyInput))
                
                
                let vc = UIHostingController(rootView: MainScreen(keyInput: self.keyInput).environment(\.managedObjectContext, self.persistenceController.container.viewContext))
                
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
                
                self.goToView = false
                
                
                self.keyInput = ""
    //            keyInput.append(contentsOf: key.characters)
                
            }
            
        }
        
        if keyInput.count == 0 {
            keyInput.append(contentsOf: key.characters)
            self.goToView = true
            
        } else {
            keyInput.append(contentsOf: key.characters)
            goToView = false
        }
        
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
//            print("async after 300 milliseconds")
//
//            if self.goToView == true {
//
//                print("lets go the view controller")
//    //            let vc = UIHostingController(rootView: MainScreen(keyInput: keyInput))
//
//
//                let vc = UIHostingController(rootView: MainScreen(keyInput: self.keyInput).environment(\.managedObjectContext, self.persistenceController.container.viewContext))
//
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true)
//
//
//
//
//                self.keyInput = ""
//    //            keyInput.append(contentsOf: key.characters)
//
//
//            }
//        }
       
        
        
//        else if keyInput.count == 10  {
//
//
//            print("lets go the view controller")
////            let vc = UIHostingController(rootView: MainScreen(keyInput: keyInput))
//
//
//            let vc = UIHostingController(rootView: MainScreen(keyInput: keyInput).environment(\.managedObjectContext, persistenceController.container.viewContext))
//
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true)
//
//            goToView = false
//
//
//            keyInput = ""
////            keyInput.append(contentsOf: key.characters)
//
//
//
//        }
        
        


    }
    
    func changeDate(input: Date, minusDays: String) -> Date? {

        let minusDays = Int(minusDays) ?? 2
        let daysToSubstract = minusDays - 1


       let currentDate = Date()
        var dateComponent = DateComponents()

        dateComponent.month = 1
        dateComponent.day = -daysToSubstract

        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        print(dateFormatter.string(from: futureDate!))

        //adding time to our future Date

        let date = dateFormatter.string(from: futureDate!)
        dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm"

        let dateString = "\(date), 08:00"

        let updatedDate = dateFormatter.date(from: dateString)

        print("updated date is \(dateFormatter.string(from: updatedDate!)) ")

        return updatedDate
    }
    
    func setTimer() {
        
        
        let currentDate = Date()

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Create String
        let myDate = "01"

        // Set Date Format
        dateFormatter.dateFormat = "dd"

        // Convert String to Date
        let desiredDate = dateFormatter.date(from: myDate) ?? currentDate

        if dateFormatter.string(from: currentDate) > "01" {

            let days = dateFormatter.string(from: currentDate)
            changeDate(input: currentDate, minusDays: days)
            
            let updatedDate = changeDate(input: currentDate, minusDays: days) ?? currentDate

            dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm"
            
            
            // This is just to test the timer with a predefined date
            
            let testDayString = "10/24/2022, 14:16"
            
            let testDate = dateFormatter.date(from: testDayString) ?? currentDate
            
            // The test ends her

            print("The scheduled upload is set to \(dateFormatter.string(from: updatedDate))")

            let timer = Timer(fireAt: updatedDate, interval: 0, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)

            RunLoop.main.add(timer, forMode: .common)

        }
    }
    
    
    @objc func runCode() {
        print("helloWorld")
        showMonthlyuploadAlert()
        

    }
    
    
    
    
    // MARK: Setting Monthly Alert
    
    func showMonthlyuploadAlert() {
  
        let sendDataAlert = UIAlertController(title: "MESSAGE FOR MEDIC ON SHIFT", message: "Please upload this database: Scan your Badge, go to settings, click export, then delete after confirminng with Loesche through Teams", preferredStyle:  .alert)
        
        let action = UIAlertAction(title: "Got it", style: .default) { (action) in
            
            //What will happen on the app tries to connect
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        sendDataAlert.addAction(action)
        self.present(sendDataAlert, animated: true, completion: nil)

    }

}




//MARK: Resources

// https://cocoacasts.com/swift-fundamentals-how-to-convert-a-string-to-a-date-in-swift

// https://www.hackingwithswift.com/example-code/system/how-to-run-code-at-a-specific-time

//https://www.appsdeveloperblog.com/add-days-months-years-to-current-date-in-swift/
