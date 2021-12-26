//
//  KeyboardViewController.swift
//  Stickboard
//
//  Created by Jeremy Endratno on 12/24/21.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewSetup()
        
    }
    
    func mainViewSetup() {
        let mainView = UIHostingController(rootView: MainView(keyboardDelegate: self))
        addChild(mainView)
        view.addSubview(mainView.view)
        mainView.view.translatesAutoresizingMaskIntoConstraints = false
        mainView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func addText(text: String) {
        textDocumentProxy.insertText(text)
    }
}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension Color {
    static let keyboardColor = Color("KeyboardBackground")
}

extension Text {
    
}

extension View {
    func buttonLike() -> some View {
        self.background(Color.white).cornerRadius(10).shadow(radius: 0.5, x: 0, y: 1).foregroundColor(Color.black)
    }
    
    func allPad20() -> some View {
        self.padding(.leading, 20).padding(.bottom, 20).padding(.trailing, 20).padding(.top, 20)
    }
}

