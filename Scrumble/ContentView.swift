import SwiftUI

struct ContentView: View {
    @State private var rootWord = "Tropicana"
    @State private var enteredWord = ""
    @State private var foundWords = [String]()
    
    @State private var showError = false
    @State private var errorDescription = ""
    
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
            .onAppear(perform: startGame)
            .navigationTitle(rootWord)
            .onSubmit { addNewWord() }
            .alert(errorDescription, isPresented: $showError) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}


// MARK: -  Game methods

extension ContentView {
    
    private func addNewWord() {
        let answer = enteredWord.lowercased()
        
        guard !answer.isEmpty else { return }
        
        guard isOriginal(word: answer) else {
            showError(.notOriginal)
            return
        }
        
        guard isPossible(word: answer) else {
            showError(.notPossible)
            return
        }
        
        guard isReal(word: answer) else {
            showError(.notReal)
            return
        }
        
        withAnimation {
            foundWords.insert(answer, at: 0)
        }
        enteredWord = ""
    }
    
    private func startGame() {
        if let rootWordsFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let rootWordsString = try? String(contentsOf: rootWordsFileURL) {
                let rootWordsArray = rootWordsString.components(separatedBy: "/n")
                rootWord = rootWordsArray.randomElement() ?? "silkworm"
                
                return
            }
        }
        
        fatalError("Could not load start.txt")
    }
    
    private func showError(_ error: ScrumbleError) {
        errorDescription = error.description
        showError = true
    }
}

// MARK: - Word validation
    
extension ContentView {
    
    private func isOriginal(word: String) -> Bool {
        !foundWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
