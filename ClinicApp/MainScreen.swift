//
//  MainScreen.swift
//  ClinicApp
//
//  Created by Daniel Ortiz on 8/10/22.
//

import SwiftUI

struct MainScreen: View {
    
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
    
    var body: some View {
        
        NavigationView {
            

            ScrollView {
                
                VStack {
                    Spacer()
                    HStack {
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }

                        
//                        Button("Show Modal with full screen") {
//                                self.isPresented.toggle()
//
//                            }
//                            .fullScreenCover(isPresented: $isPresented, content: LoadingScreen.init)
                        
//                        NavigationLink {
//                            LoadingScreen()
//                        } label: {
//                            Image(systemName: "chevron.backward")
//                                .font(.largeTitle)
//                                .foregroundColor(.blue)
//                        }
                        
                        
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

                        NavigationLink {
                            Text("Settings button")
                        } label: {
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
            }
                .padding()
            }
        
        .padding(20)
        .navigationTitle("today")
        .navigationBarHidden(true)
            
            
        
    }
        .navigationViewStyle(.stack)
        
}
    
//    var body: some View {
//
//        NavigationView {
//
//            VStack(alignment: .center) {
//
//            Text("What brings you to the clinic today ?")
//                .font(.title)
//                .fontWeight(.semibold)
//                .foregroundColor(.white)
//                .padding(15)
//
//            ScrollView {
//                LazyVGrid(columns: columnLayout) {
//                    ForEach(allColors, id: \.description) { color in
//                        Button {
//                            selectedColor = color
//
//
//                        } label: {
//
//                            RoundedRectangle(cornerRadius: 20.0)
//                                .aspectRatio(1.0, contentMode: ContentMode.fit)
//                                .foregroundColor(color.opacity(0.85))
//                                .overlay(
//                                    Text(buttonNames[color] ?? "Not available")
//                                        .font(.system(size: 25, weight: .bold, design: .default))
//                                        .padding()
//                                        .multilineTextAlignment(.center)
//
//                                )
//                                .background(
//                                        LinearGradient(gradient: Gradient(colors: [.white, color, .black]), startPoint: .leading, endPoint: .trailing)
//                                            .cornerRadius(20.0)
//                                    )
//
//                        }
//                        .buttonStyle(.plain)
//                    }
//                }
//            }
//        }
//        .padding(20)
////        .navigationTitle( "Welcome to Starbase clinic user \(keyInput)")
//
//
////        .toolbar {
////
////
////
//////            ToolbarItem(placement: .navigationBarTrailing) {
//////                Button(action: {
//////                    print("hello")
//////                }) {
//////                    Text("\(Image(systemName: "chevron.left"))")
//////                }
//////            }
////
//////            Button(action: {
//////                // What to perform
//////                print("hello daniel")
//////            }) {
//////                // How the button looks like
//////                Text("Back")
//////                    .fontWeight(.bold)
//////                    .font(.title)
//////                    .padding()
//////                    .background(Color.purple)
//////                    .cornerRadius(40)
//////                    .foregroundColor(.white)
//////                    .padding(10)
//////                    .overlay(
//////                        RoundedRectangle(cornerRadius: 40)
//////                            .stroke(Color.purple, lineWidth: 5)
//////                    )
//////            }
////
////        }
//    }
//        .navigationViewStyle(.stack)
//        .navigationBarBackButtonHidden(false)
//}
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(keyInput: "000").previewInterfaceOrientation(.landscapeRight).preferredColorScheme(.dark)
    }
}

struct SidebarView: View {
    var body: some View {
        List {
            Text("hello")
            
        Text("hello")
            
    Text("hello")
            
        }
        .listStyle(SidebarListStyle())
    }
}
