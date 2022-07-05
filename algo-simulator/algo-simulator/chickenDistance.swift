//
//  chickenDistance.swift
//  algo-simulator
//
//  Created by 이정민 on 2022/07/05.
//

import Foundation

func chickenDistance() {
    let input = readLine()!.split(separator: " ").map({Int(String($0))!})
    
    var houses: [[Int]] = []
    var chicken: [[Int]] = []
    
    for index in 0..<input[0] {
        let line = readLine()!.split(separator: " ").map({Int(String($0))!})
        for col in line.indices {
            let object = line[col]
            
            if object == 1 { // 집
                houses.append([index, col])
            } else if object == 2 { // 치킨집
                chicken.append([index, col])
            }
        }
    }
    
//    print("집")
//    houses.forEach({print($0)})
//    print("치킨집")
//    chicken.forEach({print($0)})
    // 치킨집 중 Input[1] 개 고르는 조합
    
    var combi: [[[Int]]] = []
    combination(in: chicken, count: input[1], [], &combi)
//    print("조합")
//    combi.forEach({print($0)})
    
    // 조합들을 집의 거리와 비교해서 가장 작은 값
    let maximum = input[0] * 2 * houses.count
    var result = maximum
    for com in combi { // 조합들중 에서
        var distanceInCom = 0
        for house in houses { // 모든 집들을
            let house_row = house[0]
            let house_col = house[1]
            
            var shortestDistance = maximum // 집과 치킨의 최단거리
            for chicken in com { // 각 치킨집과의 거리를 구함
                let chicken_row = chicken[0]
                let chicken_col = chicken[1]
                
                let chickenDistance = abs(chicken_row - house_row) + abs(chicken_col - house_col) // 거리
                shortestDistance = min(shortestDistance, chickenDistance)
            }
            distanceInCom += shortestDistance
        }
        result = min(result, distanceInCom)
    }
    
    print(result)
}

private func combination(in chicken: [[Int]], count: Int, _ progress: [[Int]], _ result: inout [[[Int]]], _ index: Int = 0) {
    if progress.count == count {
        result.append(progress)
        return
    }
    
    for pick in index..<chicken.count {
        combination(in: chicken, count: count, progress + [chicken[pick]], &result, pick + 1)
    }
}
