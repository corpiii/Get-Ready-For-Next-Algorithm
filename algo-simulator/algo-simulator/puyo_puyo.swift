//
//  ppuyoppuyo.swift
//  algo-simulator
//
//  Created by 이정민 on 2022/07/01.
//

import Foundation

func puyo_puyo() {
    var map: [[String]] = []
    
    for _ in 1...12 {
        let input = Array(readLine()!).map({String($0)})
        map.append(input)
    }
    
    //map.forEach({print($0)})
    
    var puyoLocation: [String: [(Int, Int)]] = ["R" : [], "G" : [], "B" : [], "Y" : [], "P": []]
    
    // 뿌요 위치 받기
    for row in map.indices {
        for col in map[0].indices {
            let puyo = map[row][col]
            if puyo != "." {
                puyoLocation[puyo]!.append((row, col))
            }
        }
    }
    
    // 5번 반복문
    // 반복문 내에서 dfs, 터뜨리면 내리기
    var result = 0
    var isPang = true
    while isPang == true {
        var pangIndices: [[(Int, Int)]] = []
        for puyo in puyoLocation.keys {
            dfs(puyo, &puyoLocation ,&pangIndices, map)
        }
        
        if pangIndices.count >= 1 {
            result += 1
            // 터뜨리기
            for pangIndex in pangIndices {
                for (row, col) in pangIndex {
                    map[row][col] = "."
                }
            }
//
//            print("터짐")
//            map.forEach({print($0)})
            
            // 내리기
//            print("내릴 친구들")
//            pangIndices.forEach({print($0)})
            for (row, col) in pangIndices.flatMap({$0}).sorted(by: {$0.0 < $1.0}) {
                for downRow in stride(from: row-1, through: 0, by: -1) {
                    //print("\(downRow + 1) \(col) <- \(downRow) \(col)")
                    map[downRow + 1][col] = map[downRow][col]
                }
            }
//            print("내림")
//            map.forEach({print($0)})
            
            puyoLocation = ["R" : [], "G" : [], "B" : [], "Y" : [], "P": []]
            
            // 뿌요 위치 받기
            for row in map.indices {
                for col in map[0].indices {
                    let puyo = map[row][col]
                    if puyo != "." {
                        puyoLocation[puyo]!.append((row, col))
                    }
                }
            }
        } else {
            isPang = false
        }
    }
    
    print(result)
}

func dfs(_ puyo: String, _ puyoLocation: inout [String : [(Int, Int)]], _ pangIndices: inout [[(Int, Int)]], _ map: [[String]]) {
    var visited: [(Int, Int)] = []
    
    for (row, col) in puyoLocation[puyo]! {
        if map[row][col] != puyo {
            continue
        }
        var stack: [(Int, Int)] = [(row, col)]
        var pangCount: [(Int, Int)] = []
        while !stack.isEmpty {
            let node = stack.removeLast()
            if !pangCount.contains(where: {$0.0 == node.0 && $0.1 == node.1}) {
                pangCount.append(node)
            }
            
            let node_row = node.0
            let node_col = node.1
            
            if !visited.contains(where: {$0.0 == node_row && $0.1 == node_col}) {
                visited.append(node)
                
                let x_move = [1, -1, 0, 0]
                let y_move = [0, 0, 1, -1]
                
                for (x, y) in zip(x_move, y_move) {
                    let moved_x = node_row + x
                    let moved_y = node_col + y
                    
                    if 0 <= moved_x && moved_x < 12 && 0 <= moved_y && moved_y < 6 {
                        if map[moved_x][moved_y] == puyo && !visited.contains(where: {$0.0 == moved_x && $0.1 == moved_y}){
                            stack.append((moved_x, moved_y))
                        }
                    }
                }
            }
        }
        
        if pangCount.count >= 4 {
            pangIndices.append(pangCount)
        }
    }
}

