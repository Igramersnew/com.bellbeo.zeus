import Foundation

struct Levels {
    static var map: [Int: [[Int]]] {
        [
            1: level1,
            2: level2,
            3: level3,
            4: level4,
            5: level5
        ]
    }

    static var randomLevel: [[Int]] {
        let order = [0,1,2,3,4,5,6].shuffled()
        return order.map {
            level5[$0]
        }
    }

    static private var level1 = [
        [1, 0, 2, 3, 1],
        [0, 2, 1, 1, 3],
        [1, 0, 2, 3, 1],
        [0, 2, 1, 1, 3],
        [1, 0, 2, 3, 1],
        [0, 2, 1, 1, 3],
        [1, 0, 2, 3, 1]
    ]

    static private var level2 = [
        [1, 2, 3, 3, 0],
        [0, 1, 2, 3, 3],
        [3, 0, 1, 2, 3],
        [3, 3, 0, 1, 2],
        [2, 3, 3, 0, 1],
        [1, 2, 3, 3, 0],
        [0, 1, 2, 3, 3]
    ]

    static private var level3 = [
        [1, 2, 3, 3, 0],
        [0, 1, 3, 3, 3],
        [3, 0, 3, 2, 3],
        [3, 3, 3, 1, 2],
        [2, 3, 3, 3, 1],
        [1, 1, 0, 0, 0],
        [0, 1, 2, 2, 2]
    ]

    static private var level4 = [
        [1, 1, 1, 1, 1],
        [0, 1, 0, 1, 0],
        [3, 3, 3, 3, 3],
        [3, 3, 0, 3, 3],
        [3, 3, 3, 3, 3],
        [0, 2, 0, 2, 0],
        [2, 2, 2, 2, 2]
    ]

    static private var level5 = [
        [2, 2, 2, 2, 2],
        [2, 2, 1, 1, 1],
        [3, 1, 1, 1, 1],
        [3, 3, 3, 3, 3],
        [2, 2, 2, 2, 3],
        [2, 2, 2, 0, 0],
        [0, 0, 0, 0, 0]
    ]
}
