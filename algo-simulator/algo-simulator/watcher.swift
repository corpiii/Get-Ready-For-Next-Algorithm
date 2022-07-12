//
//  감시.swift
//  algo-simulator
//
//  Created by 이정민 on 2022/06/28.
//

import Foundation

func watcher() {
    let n = readLine()!.split(separator: " ").map({Int($0)!})
    var result = n[0] * n[1]
    var map: [[Int]] = []
    for _ in 1...n[0] {
        let input = readLine()!.components(separatedBy: " ").map({Int($0)!})
        map.append(input)
    }
    
    // cctv 위치 배열
    var cctvArray: [(Int, Int)] = []
    for row in 0..<n[0] {
        for col in 0..<n[1] {
            let object = map[row][col]
            if object != 0 && object != 6 {
                cctvArray.append((row, col))
            }
        }
    }
    
    cctv_dfs(cctvArray, 0, map, &result)
    print(result)
}

func cctv_dfs(_ cctvArray: [(Int, Int)], _ index: Int, _ map: [[Int]], _ result: inout Int) {
    if index == cctvArray.count {
        result = min(countWatchArea(map), result)
        return
    }
    
    let cctv = cctvArray[index] // cctv
    let number = map[cctv.0][cctv.1] // cctv 번호
    
    for vector in 0..<4 {
        var new_map = map
        new_map = watchArea(cctv, number, vector, new_map)
        cctv_dfs(cctvArray, index + 1, new_map, &result)
    }
}

func countWatchArea(_ map: [[Int]]) -> Int {
    var count = 0
    for row in map.indices {
        for col in map[0].indices {
            if map[row][col] == 0 {
                count += 1
            }
        }
    }
    
    return count
}

func watchArea(_ cctv: (Int, Int), _ number: Int, _ vector: Int, _ map: [[Int]]) -> [[Int]] {
    var new_map = map
    var directions: [Int] = []
    
    directions.append(vector)
    switch number {
    case 2:
        directions.append((vector + 2) % 4)
        break
    case 3:
        directions.append((vector + 3) % 4)
        break
    case 4:
        directions.append((vector + 1) % 4)
        directions.append((vector + 3) % 4)
        break
    case 5:
        directions = [0, 1, 2, 3]
        break
    default:
        break
    }
    
    let x_move = [-1, 0, 1, 0]
    let y_move = [0, -1, 0, 1]
    
    for direction in directions {
        let dx = x_move[direction]
        let dy = y_move[direction]
        
        var row = cctv.0 + dx
        var col = cctv.1 + dy
        
        while 0 <= row, row < map.count && 0 <= col, col < map[0].count {
            let area = new_map[row][col]
            if area == 6 {
                break
            } else if area == 0 {
                new_map[row][col] = 7
            }
            
            row += dx
            col += dy
        }
    }
    
    return new_map
}
