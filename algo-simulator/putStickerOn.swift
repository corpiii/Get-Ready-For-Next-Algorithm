//
//  putStickerOn.swift
//  algo-simulator
//
//  Created by 이정민 on 2022/06/28.
//

import Foundation

func putStickerOn() {
    let input = readLine()!.components(separatedBy: " ").map({Int($0)!})
    let height = input[0]
    let width = input[1]
    let stickerCount = input[2]
    
    var noteBookMap = Array(repeating: Array(repeating: 0, count: width), count: height)
    
    
    for _ in 1...stickerCount {
        let sticker_input = readLine()!.components(separatedBy: " ").map({Int($0)!})
        var sticker_height = sticker_input[0]
        var sticker_width = sticker_input[1]
        
        var sticker: [[Int]] = []
        for _ in 1...sticker_height {
            let sticker_row = readLine()!.components(separatedBy: " ").map({Int($0)!})
            sticker.append(sticker_row)
        }
        // sticker.forEach({print($0)}) // 스티커 잘 나옴
        
        // 4번반복
        /// 스티커의 높이 위치로 끝까지 확인
        //// 90도 회전
        
        outerLoop: for _ in 1...4 { // 1번
            if width >= sticker_width && height >= sticker_height { // 스티커가 노트북 범위 안쪽이면
                for row in 0...height - sticker_height { // 0..<0 실행
                    for col in 0...width - sticker_width {
                        if isStickerPut(row, col, sticker, in: noteBookMap) { // 붙일 수 있으면
                            for stickRow in row..<row + sticker_height { // 스티커 붙이기
                                for stickCol in col..<col + sticker_width {
                                    if noteBookMap[stickRow][stickCol] == 0 {
                                        noteBookMap[stickRow][stickCol] = sticker[stickRow - row][stickCol - col]
                                    }
                                }
                            }
                            break outerLoop
                        }
                    }
                }

            }
            // 90도 회전
            sticker = rotate90(sticker)
            sticker_height = sticker.count
            sticker_width = sticker[0].count
            
        }
//        print("스티커")
//        sticker.forEach({print($0)})
//        print("노트북")
//        noteBookMap.forEach({print($0)})
    }
    
    // 스티커 붙은칸 확인
    var result = 0
    for row in 0..<height {
        for col in 0..<width {
            if noteBookMap[row][col] == 1 {
                result += 1
            }
        }
    }
    
    print(result)
}

func isStickerPut(_ row: Int, _ col: Int, _ sticker: [[Int]], in noteBookMap: [[Int]]) -> Bool {
    for stickRow in row..<row + sticker.count {
        for stickCol in col..<col + sticker[0].count {
            if noteBookMap[stickRow][stickCol] == 1 && sticker[stickRow - row][stickCol - col] == 1{
                return false
            }
        }
    }
    return true
}

func rotate90(_ sticker: [[Int]]) -> [[Int]]{
    let originalRow = sticker.count
    let originalCol = sticker[0].count
    
    var newSticker = Array(repeating: Array(repeating: 0, count: originalRow), count: originalCol)

    var newRow = 0
    var newCol = 0
    for col in 0..<originalCol {
        for row in stride(from: originalRow - 1, through: 0, by: -1) {
            newSticker[newRow][newCol] = sticker[row][col]
            newCol += 1
        }
        newRow += 1
        newCol = 0
    }

    return newSticker
}
