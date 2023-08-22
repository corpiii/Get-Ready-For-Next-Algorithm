/*
 Runtime
 Details
 22ms
 Beats 90.94%of users with Swift
 
 Memory
 Details
 14.27MB
 Beats 50.98%of users with Swift
 
 12:45
 
 이진탐색 문제.
 
 lhs, rhs의 인덱스 관리가 조금 부족한 듯 하다.
 다른사람들이 많이 사용하는 이진탐색알고리즘을 보고 참고 해보아야 한다..
 
 찾아보니 내가 작성한 것이 대부분 사람들이 사용하는 방식의 알고리즘이 맞다.
 다만 차이가 있다면 lhs <= rhs 를 조건으로 설정하고
 rhs = index - 1 을 해준다는 것.
 
 내 알고리즘은 lhs, rhs가 1차이가 나는 상태에서 멈추게 되어
 rhs를 체크하지 못하는 상황이 되는데,
 처음에 첫 번째와 마지막을 체크해주기 때문에 정상적으로 실행된다.
 이게 더 실행속도는 빠르다.
 
 */
class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        if target <= nums[0] {
            return 0
        }

        if nums.last! <= target {
            if nums.last! == target {
                return nums.count - 1
            } else {
                return nums.count
            }
        }

        var lhs = 0
        var rhs = nums.count - 1

        while lhs < rhs {
            var index = (lhs + rhs) / 2

            if nums[index] < target {
                lhs = index + 1
            } else if nums[index] > target {
                rhs = index
            } else {
                return index
            }
        }

        print(lhs, rhs)
        return rhs
    }
}
