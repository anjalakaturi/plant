//
//  ContentView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "leaf")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Button(action: {
                print("watering plants")
            }) {
                Text("WATER")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
