//
//  ContentView.swift
//  Scrumble
//
//  Created by Nataliia Shusta on 13/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var rootWord = ""
    @State private var enteredWord = ""
    @State private var foundWords = [String]()
    
    
    var body: some View {
        VStack {
            TextField("Enter word", text: $enteredWord)
            ForEach(foundWords, id: \.self) { word in
                Text(word)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
