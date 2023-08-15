/*
 Runtime
 Beats 5.11%of users with Swift
 
 Memory
 Beats 83.07%of users with Swift
 
 21 : 48
 
 생각보다 오래걸린 문제..
 단순하게 조건을 만족하는 조합을 만들어 중복을 제거 했다.
 
 조합을 찾기위해서 인덱스를 이용한 Set을 사용하면 시간을 줄일 수 있을 듯 하다.
 */

class Solution {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let allCases = generateCases(candidates, target)

        return allCases
    }

    func generateCases(_ candidates: [Int], _ target: Int) -> [[Int]] {
        func dfs( _ current: [Int], _ currentSum: Int, _ result: inout [[Int]]) {
            if currentSum == target {
                let sortedCurrent = current.sorted()

                if !result.contains(sortedCurrent) {
                    result.append(sortedCurrent)
                }

                return
            }

            if currentSum > target {
                return
            }

            for i in candidates {
                dfs(current + [i], currentSum + i, &result)
            }
        }

        var result: [[Int]] = []
        dfs([], 0, &result)

        return result
    }
}
