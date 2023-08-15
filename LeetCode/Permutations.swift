
/*
 4:0
 
 정확히 4분 걸린 문제
 단순한 순열 문제 였다.
 
 */
class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        dfs(nums, [], &result)

        return result
    }

    func dfs(_ nums: [Int], _ current: [Int], _ result: inout [[Int]]) {
        if current.count == nums.count {
            result.append(current)
            return
        }

        let filtered = nums.filter { !current.contains($0) }

        for i in filtered {
            dfs(nums, current + [i], &result)
        }
    }
}
