//
//  MainScreen.swift
//  ClinicApp
//
//  Created by Daniel Ortiz on 8/10/22.
//

import SwiftUI
import CoreData

struct MainScreen: View {
    
    
    
    @Environment(\.managedObjectContext) private var context
    
    @State var timeRemaining = 60
    @State var jump = false
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @State var showMenu = false
    
    @State var buttonsView = false
    
    @State private var selectedNeeds: [String] = []
    
    @State var otcMeds = false
    @State var personalIllness = false
    @State var covidTest = false
    
  
    var keyInput : String
    
//    @State private var isPresented = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    let columnLayout = Array(repeating: GridItem(), count: 4)

    @State private var selectedColor = Color.gray

    let allColors: [Color] = [
        .pink,
        .red,
        .orange,
        .yellow,
        .green,
//        .mint,
        .teal,
//        .cyan,
//        .blue,
        .indigo,
        .purple,
//        .brown,
//        .gray
    ]
    
    
    let buttonNames: [Color: String] = [
        .pink: "Covid Test", .red: "Over the Counter Meds", .orange: "Personal Illness", .yellow: "yellow", .green: "green", .indigo: "indigo", .teal: "teal", .purple: "purple"
    ]
    
    
    func getTime()->String{
         let time = Date()
         let timeFormatter = DateFormatter()
         timeFormatter.dateFormat = "HH:mm"
         let stringDate = timeFormatter.string(from: time)
         return stringDate
        }
    
    func getDate()->String{
         let time = Date()
         let timeFormatter = DateFormatter()
         timeFormatter.dateFormat = "MM-dd-yyyy"
         let stringDate = timeFormatter.string(from: time)
         return stringDate
        }
    
    func saveItems() {

        let newRecord = Clinic(context: context)

        newRecord.employeeID = keyInput.trimmingCharacters(in: .controlCharacters)
        newRecord.day = getDate()
        newRecord.time = getTime()
        newRecord.covidTest = covidTest
        newRecord.otcMeds = otcMeds
        newRecord.personalIllness = personalIllness
        
        PersistenceController.shared.save()

        // You can also save by using:
        
//        do {
//            try managedObjectContext.save()
//        } catch {
//            // handle the Core Data error
//        }
        
        
    }
    
    
    func loadItems() {
        @FetchRequest(entity: Clinic.entity(), sortDescriptors: [])
         var records: FetchedResults<Clinic>
        
   }
    
    
    var body: some View {
        
        
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        NavigationView {
            
            HStack {
                
                // left side of h-stack here
                
            ScrollView {
                
                VStack {
                    
                    Spacer()
                    HStack {
                        
                        Button {
                            
                            presentationMode.wrappedValue.dismiss()
                            
                            if !otcMeds && !covidTest && !personalIllness {
                                return
                            } else {
                                saveItems()
                            }
                            
                        } label: {
                            Image(systemName: "chevron.backward")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                        
                        
             
                        Spacer()
                        
                        VStack (alignment: .center) {
                            
                            Text("Welcome to Starbase Clinic user \(keyInput)\n What brings you to the clinic today ?")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(20)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.showMenu.toggle()
                                self.buttonsView.toggle()
                            }
                        }) {
                            Image(systemName: "sidebar.trailing")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                        
                        
                    }
                    
                    
                    
                    Spacer()
                    
                    
                    LazyVGrid(columns: columnLayout) {
                        ForEach(allColors, id: \.description) { color in
                            Button {
                                selectedColor = color
                                print("button \(buttonNames[color] ?? "N/A") pressed")
                                
                                selectedNeeds.append("button \(buttonNames[color] ?? "N/A") pressed")
                                print(selectedNeeds)
                                
                                let chosenService = buttonNames[color] ?? "N/A"
                                
                                switch chosenService {
                                    
                                case "Over the Counter Meds":
                                    otcMeds = true
                                case "Covid Test":
                                    covidTest = true
                                case "Personal Illness":
                                    personalIllness = true
                                default:
                                print("hello world")
                                }
                                
                                
                            } label: {
                                
                                RoundedRectangle(cornerRadius: 20.0)
                                    .aspectRatio(1.0, contentMode: ContentMode.fit)
                                    .foregroundColor(color.opacity(0.85))
                                    .overlay(
                                        Text(buttonNames[color] ?? "Not available")
                                            .font(.system(size: 25, weight: .bold, design: .default))
                                            .padding()
                                            .multilineTextAlignment(.center)
                                        
                                    )
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [.white, color, .black]), startPoint: .leading, endPoint: .trailing)
                                            .cornerRadius(20.0)
                                    )
                                
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .disabled(buttonsView)
                }
                .padding()
                
            }
            
            .padding(20)
            .navigationTitle("today")
            .navigationBarHidden(true)
                
                //right side of h-stack here
                
                ZStack(alignment: .trailing) {
                    
                    if self.showMenu {
                        
                        SideMenuView()
                            .frame(width: 300)
                            .transition(.move(edge: .trailing))
                    }
                }
            
        } // end of H-Stack
        
    }
        .gesture(drag)
        .navigationViewStyle(.stack)
        .onAppear() {
            
            
        }
        .onReceive(timer) { _ in
                                if timeRemaining > 0 {
                                    timeRemaining -= 1
                                    print(timeRemaining)
                                } else {
                                    presentationMode.wrappedValue.dismiss()

                                    saveItems()


                                    jump = true
                                    // optional stop the timer
                                    timer.upstream.connect().cancel()
                                }
                            }
        
}
    

    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(keyInput: "000").previewInterfaceOrientation(.landscapeRight).preferredColorScheme(.dark)
    }
}

//struct MainView: View {
//    
//    @Binding var showMenu: Bool
//    
//    var body: some View {
//        Button(action: {
//            withAnimation {
//               self.showMenu = true
//            }
//        }) {
//            Text("Show Menu")
//        }
//    }
//}


// MARK: RESOURCES

// Great core data article for swiftUI
//www.answertopia.com/swiftui/a-swiftui-core-data-tutorial/
