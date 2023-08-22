/*
 10 : 12
 
 이진탐색을 두번 하는 문제
 우선 포함을 할 수 있는 row를 찾고,
 row내에서 target이 존재하는 위치를 찾았다.
 
 초기 첫 번째와 마지막을 먼저 체크하고 넘어가는 것을 즐겨 사용하고 있는데
 나쁘지 않은 듯 하다.
 */

class Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        if matrix[0][0] >= target {
            if matrix[0][0] == target {
                return true
            } else {
                return false
            }
        }

        if matrix.last!.last! <= target {
            if matrix.last!.last! == target {
                return true
            } else {
                return false
            }
        }

        let row = findRow(in: matrix, target: target)
        let result = isExist(target: target, in: matrix[row])

        return result
    }

    func findRow(in matrix: [[Int]], target: Int) -> Int {
        var start = 0
        var end = matrix.count - 1

        while start <= end {
            let index = (start + end) / 2

            if matrix[index][0] < target {
                start = index + 1
            } else if matrix[index][0] > target {
                end = index - 1
            } else {
                return index
            }
        }

        return end
    }

    func isExist(target: Int, in matrix: [Int]) -> Bool {
        var start = 0
        var end = matrix.count - 1

        while start <= end {
            let index = (start + end) / 2

            if matrix[index] < target {
                start = index + 1
            } else if matrix[index] > target {
                end = index - 1
            } else {
                return true
            }
        }

        return false
    }
}
