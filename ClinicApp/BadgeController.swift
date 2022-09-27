//
//  SwiftUIViewViewController.swift
//  ClinicApp
//
//  Created by Daniel Ortiz on 8/10/22.
//

import UIKit
import SwiftUI

class BadgeController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
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
        
//        print(keyInput.count)
       
        
        
        
        if keyInput.count == 0 {
            keyInput.append(contentsOf: key.characters)
        } else if keyInput.count == 7 {
            
            print("lets go the view controller")
            let vc = UIHostingController(rootView: MainScreen(keyInput: keyInput))
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
            
            
            
            keyInput = ""
            keyInput.append(contentsOf: key.characters)
            
            
            
        } else {
            keyInput.append(contentsOf: key.characters)
        }

//        print(keyInput)
        
        
        
        
    }

}
