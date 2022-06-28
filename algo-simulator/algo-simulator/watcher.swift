//
//  감시.swift
//  algo-simulator
//
//  Created by 이정민 on 2022/06/28.
//

import Foundation

enum Vector {
    case up
    case down
    case right
    case left
}

func watcher() {
    let n = readLine()!.split(separator: " ").map({Int($0)!})
    var map: [[Int]] = []
    for _ in 1...n[0] {
        let input = readLine()!.components(separatedBy: " ").map({Int($0)!})
        map.append(input)
    }
    
    //map.forEach({print($0)})
    
    // 빈칸수 가지기?
    // 1~5 번 딕셔너리 만들기
    
    // 1번 4방향 돌리기 4개의 배열 중 가장 많은 숫자 적용하기
    // 2번 2방향
    // 3번 4방향
    // 4번 4방향
    // 5번 1방향 역순합시다
    
    var watcherPosition: [Int : [[Int]]] = [1:[], 2:[], 3:[], 4:[], 5:[]]
    
    for row in map.indices {
        for col in map[row].indices {
            switch map[row][col] {
            case 1:
                watcherPosition[1]!.append([row, col])
                break
            case 2:
                watcherPosition[2]!.append([row, col])
                break
            case 3:
                watcherPosition[3]!.append([row, col])
                break
            case 4:
                watcherPosition[4]!.append([row, col])
                break
            case 5:
                watcherPosition[5]!.append([row, col])
                break
            default:
                break
            }
        }
    }

    
    for watcher in stride(from: 5, through: 1, by: -1) {
        for position in watcherPosition[watcher]! {
            var maximumWatch: [[Int]] = []
            
            if watcher == 5 {
                watcher_5(position, &map, limitted_row: n[0], limitted_col: n[1])
            } else if watcher == 4 {
                watcher_4(position, &map, limitted_row: n[0], limitted_col: n[1], &maximumWatch)
            } else if watcher == 3 {
                watcher_3(position, &map, limitted_row: n[0], limitted_col: n[1], &maximumWatch)
            } else if watcher == 2 {
                watcher_2(position, &map, limitted_row: n[0], limitted_col: n[1], &maximumWatch)
            } else if watcher == 1 {
                watcher_1(position, &map, limitted_row: n[0], limitted_col: n[1], &maximumWatch)
            }
        }
//        map.forEach({print($0)})
    }
    
    var result = 0
    for row in map.indices {
        for col in map[row].indices {
            if map[row][col] == 0 {
                result += 1
            }
        }
    }
    
    print(result)
}

func watcher_5(_ position: [Int], _ map: inout [[Int]] , limitted_row: Int, limitted_col: Int) {
    let row = position[0]
    let col = position[1]
    
    var result: [[Int]] = []
    for direction in [Vector.up, Vector.right, Vector.down, Vector.left] {
        result += straight(row, col, direction, map)
    }
    
    for position in result {
        map[position[0]][position[1]] = -1
    }
}

func watcher_4(_ position: [Int], _ map: inout [[Int]] , limitted_row: Int, limitted_col: Int, _ maximumWatch: inout [[Int]]) {
    let row = position[0]
    let col = position[1]
    
    let directions = [Vector.up, Vector.right, Vector.down, Vector.left]
    
    var watchesByDirection: [[[Int]]] = []
    for time in 0...3 {
        let vectors = [time, time + 1, time + 2]
        var result: [[Int]] = []
        for direction in vectors {
            result += straight(row, col, directions[direction % 4], map)
        }
        watchesByDirection.append(result)
    }
    
    var maxIndex = 0
    for index in watchesByDirection.indices {
        if watchesByDirection[index].count > watchesByDirection[maxIndex].count {
            maxIndex = index
        }
    }
    
    for position in watchesByDirection[maxIndex] {
        map[position[0]][position[1]] = -1
    }
    
    //print(watchesByDirection.max(by: {$0.count}))
    //watchesByDirection.forEach({print($0)})
}

func watcher_3(_ position: [Int], _ map: inout [[Int]] , limitted_row: Int, limitted_col: Int,_ maximumWatch: inout [[Int]]) {
    let row = position[0]
    let col = position[1]
    
    let directions = [Vector.up, Vector.right, Vector.down, Vector.left]
    var watchesByDirection: [[[Int]]] = []
    for time in 0...3 {
        let vectors = [time, time + 1]
        var result: [[Int]] = []
        for direction in vectors {
            result += straight(row, col, directions[direction % 4], map)
        }
        watchesByDirection.append(result)
    }
    
    var maxIndex = 0
    for index in watchesByDirection.indices {
        if watchesByDirection[index].count > watchesByDirection[maxIndex].count {
            maxIndex = index
        }
    }
    
    for position in watchesByDirection[maxIndex] {
        map[position[0]][position[1]] = -1
    }
    
}
func watcher_2(_ position: [Int], _ map: inout [[Int]] , limitted_row: Int, limitted_col: Int, _ maximumWatch: inout [[Int]]) {
    let row = position[0]
    let col = position[1]
    
    let directions = [Vector.up, Vector.right, Vector.down, Vector.left]
    var watchesByDirection: [[[Int]]] = []
    for time in 0...1 {
        let vectors = [time, time + 2]
        var result: [[Int]] = []
        for direction in vectors {
            result += straight(row, col, directions[direction % 4], map)
        }
        watchesByDirection.append(result)
    }
    
    var maxIndex = 0
    for index in watchesByDirection.indices {
        if watchesByDirection[index].count > watchesByDirection[maxIndex].count {
            maxIndex = index
        }
    }
    
    for position in watchesByDirection[maxIndex] {
        map[position[0]][position[1]] = -1
    }
}
func watcher_1(_ position: [Int], _ map: inout [[Int]] , limitted_row: Int, limitted_col: Int, _ maximumWatch: inout [[Int]]) {
    let row = position[0]
    let col = position[1]
    
    let directions = [Vector.up, Vector.right, Vector.down, Vector.left]
    var watchesByDirection: [[[Int]]] = []
    for time in 0...3 {
        let vectors = [time]
        var result: [[Int]] = []
        for direction in vectors {
            result += straight(row, col, directions[direction % 4], map)
        }
        watchesByDirection.append(result)
    }
    
    var maxIndex = 0
    for index in watchesByDirection.indices {
        if watchesByDirection[index].count > watchesByDirection[maxIndex].count {
            maxIndex = index
        }
    }
    
    for position in watchesByDirection[maxIndex] {
        map[position[0]][position[1]] = -1
    }
}

func straight(_ row: Int, _ col: Int, _ direction: Vector, _ map: [[Int]]) -> [[Int]] {
    var row = row
    var col = col
    var result: [[Int]] = []
    if direction == .up { // 위
        while row != -1 {
            let value = map[row][col]
            if value == 6 {
                break
            } else if value == 0 {
                result.append([row, col])
            }
            row -= 1
        }
    } else if direction == .right { // 오른쪽
        while col != map[row].count {
            let value = map[row][col]
            if value == 6 {
                break
            } else if value == 0 {
                result.append([row, col])
            }
            
            col += 1
        }
    } else if direction == .down { // 아래
        while row != map.count {
            let value = map[row][col]
            if value == 6 {
                break
            } else if value == 0 {
                result.append([row, col])
            }
            
            row += 1
        }
    } else if direction == .left { // 왼쪽
        while col != -1 {
            let value = map[row][col]
            if value == 6 {
                break
            } else if value == 0 {
                result.append([row, col])
            }
            
            col -= 1
        }
    }
    
    return result
}
