//
//  MainView.swift
//  Stickboard
//
//  Created by Jeremy Endratno on 12/24/21.
//

import SwiftUI

struct MainView: View {
    var keyboardDelegate: KeyboardViewController
    var sticks = KeyboardData().read()
    var grids = [
        GridItem(.flexible(minimum: 20, maximum: 50), alignment: .leading),
        GridItem(.flexible(minimum: 20, maximum: 50), alignment: .leading),
        GridItem(.flexible(minimum: 20, maximum: 50), alignment: .leading)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                LazyHGrid(rows: grids, spacing: 20) {
                    ForEach(sticks, id: \.id) { stick in
                        NavigationLink(destination: DetailView(keyboardDelegate: keyboardDelegate, stick: stick)) {
                            Text("\(stick.name)").frame(width: 115).padding(10).buttonLike()
                        }
                    }
                }
                .allPad20()
            }
            .navigationTitle("Stickiz")
            .navigationBarTitleDisplayMode(.inline)
            .frame(width: UIScreen.screenWidth, height: 200)
            .background(Color("KeyboardBackground"))
        }
    }
}
