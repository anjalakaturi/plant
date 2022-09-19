//
//  AddView.swift
//  PlantTracker
//
//  Created by Anjala Katuri on 9/19/22.
//

import Foundation
import SwiftUI

struct UpdateView: View {
    var body: some View {
        VStack {
            Text("Plant Name")
                .font(.largeTitle)
            //Spacer()
            Button(action: {
                print("watering plants")
            }) {
                Text("WATER")
                    .fontWeight(.bold)
                    .font(.body)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.green, lineWidth: 5)
                        )
            }
        }
        .padding()
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}

