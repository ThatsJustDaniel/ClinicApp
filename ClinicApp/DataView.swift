//
//  DataView.swift
//  ClinicApp
//
//  Created by Daniel Ortiz on 10/18/22.
//

import SwiftUI
import CoreData


struct DataView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
//    @FetchRequest(entity: Clinic.entity(), sortDescriptors: [])
    @FetchRequest(entity: Clinic.entity(), sortDescriptors: [NSSortDescriptor(key: "time", ascending: true)])

    private var records: FetchedResults<Clinic>
    
    
    let columns = [
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .center),
    ]
    
    var body: some View {
        
        ScrollView {
            
        LazyVGrid(columns: columns) {
            
            // headers
            Group {
                Text("EmployeeID")
                Text("Date")
                Text("Time")
                Text("covidTest")
                Text("OTCmeds")
                Text("Illness")
            }
            .font(.headline)
            
            // content
            ForEach(records) { record in
                Text(record.employeeID ?? "Not found")
                Text(record.day ?? "Not found")
                Text(record.time ?? "Not found")
                Text(BooltoString(input:record.covidTest))
                Text(BooltoString(input:record.otcMeds))
                Text(BooltoString(input:record.personalIllness))
            }
            .onDelete(perform: deleteProducts)
        }
        .padding()
        
    }
    
    }
    
    func BooltoString(input: Bool) -> String {
        if input {
            return "true"
        } else {
            return "false"
        }
    }
    
    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { records[$0] }.forEach(viewContext.delete)
    //            saveContext()
            }
    }
    
}



struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
