//
//  laboratory.swift
//  algo-simulator
//
//  Created by 이정민 on 2022/06/28.
//

import Foundation

func laboratory() {
    func combination(_ index: Int, _ progress: [(Int, Int)]) {
        if progress.count == 3 {
            combi.append(progress)
            return
        }
        
        for position in index..<zeroPosition.count {
            combination(position + 1, progress + [zeroPosition[position]])
        }
    }
    
    let n = readLine()!.split(separator: " ").map({Int($0)!})
        
    var map: [[Int]] = []
    for _ in 1...n[0] {
        let input = readLine()!.split(separator: " ").map({Int($0)!})
        map.append(input)
    }
    
    //map.forEach({print($0)})
    
    var zeroPosition: [(Int, Int)] = []
    var virusPosition: [(Int, Int)] = []
    var safeMaximumSize: Int = 0
    for row in 0..<n[0] {
        for col in 0..<n[1] {
            let current = map[row][col]
            if current == 0 {
                zeroPosition.append((row, col))
                safeMaximumSize += 1
            } else if current == 2 {
                virusPosition.append((row, col))
            }
        }
    }
    
    //print(zeroPosition)
    
    var combi: [[(Int, Int)]] = []
    let progress: [(Int, Int)] = []
    combination(0, progress)
    
    //combi.forEach({print($0)})
    
    var result = 0
    var isFirst = true
    
    for wall in combi {
        var redrawMap = map
        for position in wall {
            redrawMap[position.0][position.1] = 1
        }
        
        let x_move = [-1, 0, 1, 0]
        let y_move = [0, -1, 0, 1]
        var safeArea = safeMaximumSize - 3
        
        outerLoop: for virus in virusPosition {
            var stack = [virus]
            while !stack.isEmpty {
                let node = stack.removeLast()
                if redrawMap[node.0][node.1] == 0 {
                    redrawMap[node.0][node.1] = 2
                    safeArea -= 1
                    if isFirst == false && safeArea == result {
                        break outerLoop
                    }
                }
                
                for (x, y) in zip(x_move, y_move) {
                    let moved_x = node.0 + x
                    let moved_y = node.1 + y
                    
                    if redrawMap.indices.contains(moved_x) && redrawMap[moved_x].indices.contains(moved_y) {
                        if redrawMap[moved_x][moved_y] == 0 {
                            stack.append((moved_x, moved_y))
                        }
                    }
                }
            }
//            print(result)
//            print("/////////////////////////////////////////")
//            redrawMap.forEach({print($0)})
            
        }
        if isFirst == true {
            result = safeArea
            isFirst = false
        } else {
            if result < safeArea {
                result = safeArea
            }
            
        }
    }
    
    print(result)
}
