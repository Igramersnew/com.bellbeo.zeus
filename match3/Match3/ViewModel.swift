import Combine
import Foundation

enum Update {
    case start
    case startHard
    case startEasy
    case descriptionShown
    case restartGame
    case showStore
    case nextLevel
    case previousLevel
    case showMenu
    case hideStore
    case buy(Bonus)
}

enum Bonus {
    case double
    case triple

    var cost: Int {
        switch self {
        case .double:
            return 550
        case .triple:
            return 980
        }
    }

    var time: Int {
        switch self {
        case .double:
            return 100
        case .triple:
            return 200
        }
    }
}

enum Screen {
    case loading
    case menu
}

struct GameItem: Equatable, Hashable {
    let id: Int
    let image: String

    var score: Int {
        id * 50
    }
}

extension ViewModel {
    struct Constant {
        static let boardWidth = 5
        static let boardHeight = 7

        static let rows = (0..<boardHeight)
        static let columns = (0..<boardWidth)
        static let cellCount: Int = boardWidth * boardHeight
        static let aspectRatio = Double(boardWidth) / Double(boardHeight)

        static let timeBase = 100

        static let gameElements = [
            GameItem(id: 1, image: "item_1"),
            GameItem(id: 2, image: "item_2"),
            GameItem(id: 3, image: "item_3"),
            GameItem(id: 4, image: "item_4")
        ]
    }

    struct Cell: Identifiable, Hashable {
        let id: UUID = .init()
        var position: Int
        var content: Int
        var isMatched = false
    }
}

final class ViewModel: ObservableObject {
    static let shared: ViewModel = .init()

    private var difficulty = 1
    private var timer: Timer?
    private var appliedBonus: Int = 0
    var timeLimit: Int { Constant.timeBase / difficulty + appliedBonus }

    @Published var descriptionShown: Bool = true
    @Published var gameShown: Bool = false
    @Published var storeShown: Bool = false
    @Published var currentScreen: Screen = .loading
    @Published private(set) var cells: [Cell] = []
    @Published var score: Int = 1000
    @Published var level: Int
    @Published var maxLevel: Int = 1
    @Published var timeLeft: Int = 100
    @Published var isFinished = false
    @Published var isWin = false

    init() {
        level = (UserDefaults.standard.value(forKey: "level") as? Int) ?? 1
        maxLevel = (UserDefaults.standard.value(forKey: "max") as? Int) ?? 1
        descriptionShown = (UserDefaults.standard.value(forKey: "descriptionShown") as? Bool) ?? false
        currentScreen = descriptionShown ? .menu : .loading
    }

    func send(update: Update) {
        switch update {
        case .start:
            currentScreen = .menu
        case .startHard:
            difficulty = 2
            gameShown = true
            reloadBoard()
        case .startEasy:
            difficulty = 1
            gameShown = true
            reloadBoard()
        case .restartGame:
            if isWin {
                send(update: .nextLevel)
                reloadBoard()
            } else {
                reloadBoard()
            }
        case .showStore:
            storeShown = true
        case .nextLevel:
            level = min(100, min(maxLevel, level + 1))
            UserDefaults.standard.set(level, forKey: "max")
        case .previousLevel:
            level = max(1, level - 1)
            UserDefaults.standard.set(level, forKey: "max")
        case .showMenu:
            gameShown = false
            storeShown = false
        case .hideStore:
            storeShown = false
        case .buy(let bonus):
            if bonus.cost < score {
                timeLeft += bonus.time
                appliedBonus += bonus.time
                score -= bonus.cost
            }
        case .descriptionShown:
            descriptionShown = true
            UserDefaults.standard.setValue(descriptionShown, forKey: "descriptionShown")
        }
    }

    func exchange(_ sourceIndex: Int, with destinationIndex: Int) {
        cells.swapAt(sourceIndex, destinationIndex)
        cells[sourceIndex].position = sourceIndex
        cells[destinationIndex].position = destinationIndex

        score -= level * 10

        if checkWin() {
            isFinished = true
            isWin = true
            maxLevel = level + 1
            score += level * 100 + timeLeft * 5
            timer?.invalidate()
            timer = nil
            appliedBonus = 0
            UserDefaults.standard.set(maxLevel, forKey: "max")
        }
    }

    func reloadBoard() {
        isFinished = false
        isWin = false
        timeLeft = timeLimit
        cells = newBoard()

        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.timeLeft -= 1
            if self?.timeLeft == .zero {
                timer.invalidate()
                self?.timer = nil
                self?.isWin = false
                self?.isFinished = true
            }
        }
    }

    static func isAdjacent(_ sourceIndex: Int, to destinationIndex: Int) -> Bool {
        let (sourceX, sourceY) = Self.coordinate(for: sourceIndex)
        let (destinationX, destinationY) = Self.coordinate(for: destinationIndex)
        let dx = abs(sourceX - destinationX)
        let dy = abs(sourceY - destinationY)
        return dx + dy == 1
    }

    private static func coordinate(for index: Int) -> (Int, Int) {
        (index % Constant.boardWidth, index / Constant.boardWidth)
    }

    private func newBoard() -> [Cell] {
        return (0..<Constant.cellCount).map {
            let x = $0 / Constant.boardWidth
            let y = $0 % Constant.boardWidth
            let levelMap = Levels.map[level] ?? Levels.randomLevel
            return Cell(position: $0, content: levelMap[x][y])
        }
    }

    private func checkWin() -> Bool {
        let checkSequenses = (0..<Constant.boardWidth).map { line in
            return (0..<Constant.boardHeight).map { Constant.boardWidth * $0 + line }
        }

        return checkSequenses.reduce(true) { result, line in
            guard let first = line.first else { return false }
            let cellContent = cells[first].content
            return result && line.allSatisfy { cells[$0].content == cellContent }
        }
     }
}
