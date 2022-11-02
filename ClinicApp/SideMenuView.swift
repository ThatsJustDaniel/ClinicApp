//
//  SideMenu.swift
//  ClinicApp
//
//  Created by Daniel Ortiz on 10/12/22.
//

import SwiftUI
import UIKit
import MessageUI
import CoreData

struct SideMenuView: View {
    
    let persistenceController = PersistenceController.shared
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingAlert = false
    @State private var showingCSV = false
    @State private var showingDataView = false
    @State private var showingDeleteView = false
    
    var body: some View {
        
      
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "trash")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Button("Delete") {
                    showingDeleteView = true
                    }
                    .foregroundColor(.gray)
                    .font(.headline)
            }
.padding(.top, 30)
            
            HStack {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Button("Data View") {
                                showingDataView = true
                                }
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
            .padding(.top, 30)
            
            HStack {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Button("Export") {
//                                showingCSV = true

                                if MFMailComposeViewController
                                    .canSendMail() {
                                    showingCSV = true
                                } else {
                                    showingAlert = true
                                }
                                    
                                }
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                        .padding(.top, 30)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showingCSV) {
            csvBridge()
            
        }
        .sheet(isPresented: $showingDeleteView) {
            DeleteView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
        .sheet(isPresented: $showingDataView) {
            DataView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
        .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Could not send email"), message: Text("Your device could not send e-mail.  Please check e-mail configuration and try again."), dismissButton: .default(Text("OK")))
                }
        
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

// MARK: This is the interface way to wrap UIViewControllers in SwiftUI

struct csvBridge: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        let csv = csvController()
        return csv
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

        
    }

}



