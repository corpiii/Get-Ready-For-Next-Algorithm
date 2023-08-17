/*
 50:22
 Runtime
 Beats 80.81%of users with Swift
 
 Memory
 Beats 26.26%of users with Swift
 
 체스판의 퀸을 한 row당 하나씩 두며 서로 영향을 미치지 않도록 구성하는 모든 경우의 수를 구하는 문제
 
 dfs를 돌며 조건에 만족하는 경우 dfs를 들어감.
 조건에 만족하지 않는 경우 더이상 진행하지 않음.
 
 실수를 너무 많이 해서 오래걸렸다.
 우선 대각선을 체크하지 않아서 시간이 소요됐고,
 대각선을 체크하며 기울기가 1인 것을 찾으려 했는데
 x,y증가량이 각각 4, 3이라 기울기가 4 / 3인 경우, 그냥 나누기를 진행해서 1이 되어버리는 오류를 늦게 찾았다.
 
 또한 조건을 따로 함수로 분리하지 않아서 생각이 꼬이는게 많았다.
 함수 분리를 확실히 하자.
 */
class Solution {
    func solveNQueens(_ n: Int) -> [[String]] {
        var result: [[String]] = []
        dfs(n, [], &result)

        return result
    }

    func dfs(_ n: Int, _ current: [Int], _ result: inout [[String]]) {
        if current.count == n {
            var tempArray: [String] = []

            for i in current {
                var dotArray = Array(repeating: ".", count: n)
                dotArray[i - 1] = "Q"
                tempArray.append(dotArray.joined())
            }
            result.append(tempArray)
            return
        }

        for col in 1...n {

            if current.contains(col) {
                continue
            }

            if isPossible(current.count + 1, col, in: current) {
                dfs(n, current + [col], &result)
            }
        }
    }

    func isPossible(_ row: Int, _ col: Int, in current: [Int]) -> Bool {
        if current.count == 0 {
            return true
        }

        if current.contains(col) {
            return false
        }
        
        for currentRow in 1...current.count {
            let currentCol = current[currentRow - 1]
            if abs(Double(row - currentRow) / Double(col - currentCol)) == 1 {
                return false
            }
        }

        return true
    }

}
