//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Jason Yang on 15/06/21.
//

import SwiftUI

struct ViewTitle: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            Text(text)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding(5)
                .background(Color.white)
        }
    }
}

extension View {
    func viewTitle(with text: String) -> some View {
        self.modifier(ViewTitle(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
                .frame(width: 300, height: 300, alignment: .center)
                .viewTitle(with: "#100DaysOfSwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
