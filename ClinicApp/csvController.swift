//
//  ViewController.swift
//  testingCSV
//
//  Created by Daniel Ortiz on 10/11/22.
//

import UIKit
import MessageUI
import SwiftUI
import CoreData

class csvController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    // Variables
    var columnTitles: String = "Employee ID, Day, Time, Covid Test, OTC Meds, Personal Illness"
    var recordsArray:[String] = []
    var convertMutable: NSMutableString!
    var incomingString: String = ""
    var datastring: NSString!
    

    // Mail alert if user does not have email setup on device
    func showSendMailErrorAlert() {
  
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle:  .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            //What will happen on the app tries to connect
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        sendMailErrorAlert.addAction(action)
        self.present(sendMailErrorAlert, animated: true, completion: nil)

    }
    // MARK: MFMailComposeViewControllerDelegate Method

    private func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        
        
        self.view.backgroundColor = .clear
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        for i in 1...10 {
//
//
//            toDoItems.append(columnTitles)
//
//             }
        loadItems()
        csvExport()
//
//        print("these are the items that are being loaded")
//        loadItems()
    }


        func csvExport() {
        
        // Convert tableView String Data to NSMutableString
            convertMutable = NSMutableString();
            for item in recordsArray
            {
                convertMutable.appendFormat("%@\r", item)
            }

            print("NSMutableString: \(convertMutable)")

            // Convert above NSMutableString to NSData
        let data = convertMutable.data(using: NSUTF8StringEncoding, allowLossyConversion: false)
            if let d = data { // Unwrap since data is optional and print
                print("NSData: \(d)")
            }
            
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/yyyy"
            
            let fileTitle = formatter.string(from: currentDate)
            

            //Email Functions
            func configuredMailComposeViewController() -> MFMailComposeViewController {
                let mailComposerVC = MFMailComposeViewController()
                mailComposerVC.mailComposeDelegate = self
                mailComposerVC.setToRecipients(["you@yoursite.com"])
                mailComposerVC.setSubject("\(fileTitle) Starbase clinic records")
                mailComposerVC.setMessageBody("", isHTML: false)
                mailComposerVC.addAttachmentData(data!, mimeType: "text/csv", fileName: "Clinic_\(fileTitle).csv")

                return mailComposerVC
            }

            // Compose Email
            let mailComposeViewController = configuredMailComposeViewController()
            
            if MFMailComposeViewController.canSendMail() {

                self.present(mailComposeViewController, animated: true, completion: nil)

            } else {
                self.showSendMailErrorAlert() // One of the MAIL functions
            }
            
            
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        print("going back")
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: CORE DATA
    
    //SwiftUI Persistence controller setup. This is the Container that all the SwiftUI view use. However, here we are mixing the implementation of SwiftUI calls and UIkit calls for this container.
    
    let persistenceController = PersistenceController.shared
    
    let context = PersistenceController.shared.container.viewContext
    

    
    // Below is the old way of getting access to our SwiftUI container. Since our data is updated and accessed in SwiftUI, we need to access the data in a SwiftUI way.
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func loadItems() {
        
       let request : NSFetchRequest<Clinic> = Clinic.fetchRequest()
        
    
       do {
           
           let records = try context.fetch(request)
                   
           recordsArray.append(columnTitles)
           
           for record in records {
               
               let row = "\(record.employeeID ?? "00000"), \(record.day ?? "01-01-2022"), \(record.time ?? "00:00"), \(record.covidTest), \(record.otcMeds), \(record.personalIllness)"
               
               print(row)
               print(record)
               recordsArray.append(row)
           }
           
           print("the records array is \(records)")
       } catch {
           print("Error fetching data from context \(error)")
       }

   }

    
    }




