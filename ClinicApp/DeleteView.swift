//
//  SwiftUIView.swift
//  ClinicApp
//
//  Created by Daniel Ortiz on 10/24/22.
//

import SwiftUI
import CoreData

struct DeleteView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
        @FetchRequest(entity: Clinic.entity(), sortDescriptors: [])
    
    private var records: FetchedResults<Clinic>
    
    
    @State var input: String = ""
   @State var Answer: String = ""
   @State var ShowButton: Bool = false
   @State var TextFieldVal: Bool = false
    @FocusState private var keyboardFocused : Bool
    
    
    var body: some View {
        
        VStack {
            
            Text(Answer)
                                        .frame(width: 400, height: 40, alignment: .center)
                                        .font(.title)
                                        .foregroundColor(Color.white)
            
            SecureField("Type here you Password", text: $input)
                .textFieldStyle(.roundedBorder)
                .frame(width: 250, height: 40, alignment: .center)
//                .background(Color.white.opacity(0.8).cornerRadius(15))
                .foregroundColor(.white)
                .font(.headline)
//                .keyboardType(.decimalPad)
                .padding(30)
                .focused($keyboardFocused)
            
            Button(action: {
                
                if TextFieldVal == true {
                    
                    Answer = String ("Records deleted")
                    
                    for record in records {
                        viewContext.delete(record)
                    }
                    if viewContext.hasChanges {
                        try? viewContext.save()
                    }
                    print("Delete tapped!")
                    
                    } else {
                    Answer = ("Incorrect Password")
                    }
                
            }) {
                HStack {
                    Image(systemName: "trash")
                        .font(.title)
                    Text("Delete")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
            }
            
        }
        .onChange(of: input) { _ in
                    if input == "1234" {
                        TextFieldVal = true
                    } else {
                        TextFieldVal = false
                    }
                }



    }
    
    
}

//struct DeleteUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeleteView()
//    }
//}
