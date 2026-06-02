//
// ContentView.swift
// CursorTracking
//
// Created by Ashutosh Kumar Singh on 25/10/25.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    // Use the artboard that contains your grid of arrows
    let riveViewModel = RiveViewModel(
        fileName: "cursor_tracking",
        stateMachineName: "State Machine 1",
        artboardName: "Artboard" // Replace with your grid artboard name
       
    )
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            riveViewModel.view()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
// made in india

