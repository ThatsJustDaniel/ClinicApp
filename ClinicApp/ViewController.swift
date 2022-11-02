////
////  ViewController.swift
////  ClinicApp
////
////  Created by Daniel Ortiz on 6/30/22.
////
//
//import UIKit
//import SwiftUI
//
//class ViewController: UIViewController {
//
////    var uploadView = true
//
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//            present(vc, animated: true)
//
//
//        let currentDate = Date()
//
//        // Create Date Formatter
//        let dateFormatter = DateFormatter()
//
//        // Create String
//        let myDate = "01"
//
//        // Set Date Format
//        dateFormatter.dateFormat = "dd"
//
//        // Convert String to Date
//        let desiredDate = dateFormatter.date(from: myDate) ?? currentDate
//
//        if dateFormatter.string(from: currentDate) > "01" {
//
//            let days = dateFormatter.string(from: currentDate)
//            changeDate(input: currentDate, minusDays: days)
//            let updatedDate = changeDate(input: currentDate, minusDays: days)
//
//            dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm"
//
//            print("The scheduled upload is set to \(dateFormatter.string(from: updatedDate!))")
//
//            let timer = Timer(fireAt: updatedDate!, interval: 0, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)
//
//            RunLoop.main.add(timer, forMode: .common)
//
//        }
//
//
//    }
//
//    @objc func runCode() {
//        print("helloWorld")
//
//    }
//
//    func changeDate(input: Date, minusDays: String) -> Date? {
//
//        let minusDays = Int(minusDays) ?? 2
//        let daysToSubstract = minusDays - 1
//
//
//       let currentDate = Date()
//        var dateComponent = DateComponents()
//
//        dateComponent.month = 1
//        dateComponent.day = -daysToSubstract
//
//        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//
//        print(dateFormatter.string(from: futureDate!))
//
//        //adding time to our future Date
//
//        let date = dateFormatter.string(from: futureDate!)
//        dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm"
//
//        let dateString = "\(date), 08:00"
//
//        let updatedDate = dateFormatter.date(from: dateString)
//
//        print("updated date is \(dateFormatter.string(from: updatedDate!)) ")
//
//        return updatedDate
//    }
//
//    let vc = UIHostingController(rootView: LoadingScreen())
//
//
//    // MARK: Auto-upload database
//
//
//    var timer: DispatchSourceTimer?
//
//    func startTimer(in interval: DispatchTimeInterval, block: @escaping () -> Void) {
//
//
//
//
//
//        timer = DispatchSource.makeTimerSource(flags: .strict, queue: .main)
//        timer?.setEventHandler(handler: block)
//        timer?.schedule(deadline: .distantFuture + interval, leeway: .milliseconds(500))
//        timer?.activate()
//    }
//
//
//
//
//    //Mark: Variables
//
//    @IBOutlet var firstVisitButton: UIButton!
//
//
//    @IBOutlet var followUpVisitButton: UIButton!
//
//
//    @IBOutlet var overTheCounterMedsButton: UIButton!
//
//
//    @IBOutlet var personalIllnessButton: UIButton!
//
//    var covidTestArray = [String]()
//
//
//
//}
//
//
