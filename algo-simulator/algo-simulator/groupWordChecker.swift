//
//  groupWordChecker.swift
//  algo-simulator
//
//  Created by 이정민 on 2022/06/28.
//

import Foundation

func groupWordChecker() {
    let n = Int(readLine()!)!
    
    var words: [[String]] = []
    for _ in 1...n {
        words.append(Array(readLine()!).map({String($0)}))
    }
    
    var result = n
    
    for word in words {
        var checkerArray: [String] = []
        var letterCheck = " "
        for letter in word {
//            print(letter, terminator: " ")
//            print(letterCheck)
            if letterCheck != letter {
                if checkerArray.contains(letter) { // 이미 들어있으면 틀림
                    result -= 1
                    break
                } else { // 처음들어오면 ㄱㅊ
                    checkerArray.append(letter)
                    letterCheck = letter
                }
            }
        }
    }
    print(result)
}
