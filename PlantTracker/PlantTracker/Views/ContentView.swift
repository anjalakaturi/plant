//
//  ContentView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/14/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image(systemName: "leaf")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            //Spacer()
            if let testPlant = PlantData.p0
            {
                Text("\(testPlant.name)")
            } else {
                Text("No person found.")
            }
            Button(action: {
                print("watering plants")
            }) {
                Text("WATER")
                    .fontWeight(.bold)
                    .font(.body)
                    .padding(5)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(5)
                    .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.blue, lineWidth: 4)
                        )
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
