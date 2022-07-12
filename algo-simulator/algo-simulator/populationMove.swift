//
//  File.swift
//  algo-simulator
//
//  Created by 이정민 on 2022/07/12.
//

import Foundation

func populationMove() {
    let input = readLine()!.components(separatedBy: " ").map({Int(String($0))!})
    let N = input[0]
    let L = input[1]
    let R = input[2]
    
    var result = 0
    
    var map: [[Int]] = []
    for _ in 0..<N {
        let line = readLine()!.components(separatedBy: " ").map({Int(String($0))!})
        map.append(line)
    }
    
    // 연합이 빌때까지 반복
    while true {
        var unions: [[(Int, Int)]] = []
        var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: N), count: N)
        
        for row in 0..<N {
            for col in 0..<N {
                var countries: [(Int, Int)] = [(row, col)]
                
                // 연합 만들기
                var stack: [(Int, Int)] = [(row, col)]
                while !stack.isEmpty {
                    let country = stack.removeLast()
                    
                    if visited[country.0][country.1] == false {
                        visited[country.0][country.1] = true
                        
                        let x_move = [1, -1, 0, 0]
                        let y_move = [0, 0, 1, -1]
                        
                        for (x, y) in zip(x_move, y_move) {
                            let new_row = country.0 + x
                            let new_col = country.1 + y
                            
                            if 0 <= new_row, new_row < N && 0 <= new_col, new_col < N {
                                let populationDifference = abs(map[new_row][new_col] - map[country.0][country.1])
                                if L <= populationDifference, populationDifference <= R {
                                    if visited[new_row][new_col] == false {
                                        if !countries.contains(where: {$0.0 == new_row && $0.1 == new_col}) {
                                            countries.append((new_row, new_col))
                                        }
                                        stack.append((new_row, new_col))
                                    }
                                }
                            }
                        }
                    }
                }
                
                //print((row, col), countries)
                if countries.count != 1 {
                    unions.append(countries)
                }
            }
        }
        
        // 연합이 비면 종료
        if unions.isEmpty {
            break
        }
        
        // 연합 평균화
        //print(unions)
        for union in unions {
            var total = 0
            for country in union {
                total += map[country.0][country.1]
            }
            
            let average = total / union.count
            for country in union {
                map[country.0][country.1] = average
            }
        }
        
        // 횟수 + 1
        result += 1
    }
    
    print(result)
}
