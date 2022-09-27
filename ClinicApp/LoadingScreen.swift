//
//  InitialScreen.swift
//  ClinicApp
//
//  Created by Daniel Ortiz on 8/10/22.
//

import SwiftUI

struct LoadingScreen: View {
    
    var body: some View {
        PulsatingView()
    }
}

struct PulsatingView: View {
    
    @State var animate = false
    
    var body: some View {
        ZStack {
            Capsule().fill(Color.blue.opacity(0.25)).frame(width: 800, height: 475).scaleEffect(self.animate ? 1 : 0)
            Capsule().fill(Color.blue.opacity(0.35)).frame(width: 700, height: 375).scaleEffect(self.animate ? 1 : 0)
            Capsule().fill(Color.blue.opacity(0.45)).frame(width: 600, height: 275).scaleEffect(self.animate ? 1 : 0)
            Capsule().fill(Color.blue.opacity(0.0)).frame(width: 500, height: 175)
                .overlay(
                    Text("Please scan your badge to begin")
                        .font(.system(size: 45, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        )
        }.onAppear {
            self.animate.toggle()
        }
        .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: true))
    }
}

struct InitialScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
