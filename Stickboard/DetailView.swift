//
//  DetailView.swift
//  Stickboard
//
//  Created by Jeremy Endratno on 12/25/21.
//

import SwiftUI

struct DetailView: View {
    var keyboardDelegate: KeyboardViewController
    var stick: StickModel
    
    var grids = [
        GridItem(.flexible(minimum: 20, maximum: 50), alignment: .leading),
        GridItem(.flexible(minimum: 20, maximum: 50), alignment: .leading),
        GridItem(.flexible(minimum: 20, maximum: 50), alignment: .leading)
    ]
    
    var body: some View {
        let stickDatas = KeyboardData().readByStickID(stick_id: stick.id)
        ScrollView(.horizontal) {
            LazyHGrid(rows: grids, spacing: 20) {
                ForEach(stickDatas, id: \.id) { data in
                    Button {
                        keyboardDelegate.addText(text: data.value)
                    } label: {
                        Text("\(data.name)").frame(width: 115).padding(10).buttonLike()
                    }

                }
            } .allPad20().navigationTitle(stick.name).navigationBarTitleDisplayMode(.inline)
        }
        .frame(width: UIScreen.screenWidth, height: 200)
        .background(Color("KeyboardBackground"))
    }
}
