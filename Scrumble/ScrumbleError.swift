import Foundation

enum  ScrumbleError: String {
    case notPossible
    case notReal
    case notOriginal
    case isRootWord
    
    var description: String {
        switch self {
        case .notPossible: return "Can not be constructed from root word"
        case .notReal: return "This word does not exist"
        case .notOriginal: return "This word was used already"
        case .isRootWord: return "The word must differ from the root word"
        }
    }
}
