//
//  ContentView.swift
//  Scrumble
//
//  Created by Nataliia Shusta on 13/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var rootWord = "Tropicana"
    @State private var enteredWord = ""
    @State private var foundWords = [String]()
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter word", text: $enteredWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(foundWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit { addNewWord() }
        }
    }
    
    private func addNewWord() {
        let answer = enteredWord.lowercased()
        guard !answer.isEmpty else { return }
        
        withAnimation {
            foundWords.insert(answer, at: 0)
        }
        enteredWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
