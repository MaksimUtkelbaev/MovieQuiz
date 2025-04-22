import Foundation

final class StatisticService: StatisticServiceProtocol {
    
    private let storage = UserDefaults.standard
    
    private enum Keys: String {
        case correct = "correct"
        case total = "total"
        case date = "date"
        case bestGame = "bestGame"
        case gamesCount = "gamesCount"
        case correctAnswers = "correctAnswers"
    }
    
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.correct.rawValue)
            let total = storage.integer(forKey: Keys.total.rawValue)
            let date = storage.object(forKey: Keys.date.rawValue) as? Date ?? Date()
            let bestGame = GameResult(correct: correct, total: total, date: date)
            return bestGame
        }
        set {
            storage.set(newValue.correct, forKey: Keys.correct.rawValue)
            storage.set(newValue.total, forKey: Keys.total.rawValue)
            storage.set(newValue.date, forKey: Keys.date.rawValue)
        }
    }
    
    private var correctAnswers: Int {
        get {
            storage.integer(forKey: Keys.correctAnswers.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.correctAnswers.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        if gamesCount != 0 {
            return (Double(correctAnswers) / (Double(gamesCount) * 10.0)) * 100.0
        } else {
            return 0
        }
    }
    
    func store(gameResult: GameResult) {
        gamesCount += 1
        correctAnswers += gameResult.correct
        
        if gameResult.isBetterThan(bestGame) {
            bestGame = gameResult
        }
        }
    }

