/*
 Runtime
 1460ms
 Beats 37.44%of users with Swift
 
 Memory
 13.98mb
 Beats 98.10%of users with Swift
 
 33:46
 
 dfs로 탐색해서 찾아가며 단어가 있는지 체크하는 것.
 단순히 dfs로 돌아가며 체크해주면 되겠다 생각했는데 함수의 구성을 생각하지 못해서 조금 오래걸렸다.
 탐색문제를 훨씬 많이 풀어봐야 할 것 같다...
 
 */

class Solution {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        var result = false
        var target = word.map { String($0) }
        var queue: [[Int]] = []

        for row in 0..<board.count {
            for col in 0..<board[row].count {
                if String(board[row][col]) == target[0] {
                    queue.append([row, col])
                }
            }
        }

        for i in queue {
            dfs(i, 1, [i], &result)

            if result == true {
                break
            }
        }
        
        func dfs(_ position: [Int], _ depth: Int, _ visited: [[Int]], _ result: inout Bool) {
            if depth == target.count {
                result = true
                return
            }

            let row = position[0]
            let col = position[1]

            let dx = [0,1,0,-1]
            let dy = [1,0,-1,0]

            for i in 0...3 {
                let newX = row + dx[i]
                let newY = col + dy[i]
                
                guard 0 <= newX, newX < board.count && 0 <= newY, newY < board[0].count else {
                    continue
                }
                
                if target[depth] == String(board[newX][newY]) {
                    if visited.contains([newX, newY]) == true {
                        continue
                    }

                    if depth + 1 <= target.count {
                        dfs([newX, newY], depth + 1, visited + [[newX, newY]], &result)
                    }
                }
            }
        }

        return result
    }

        
}
