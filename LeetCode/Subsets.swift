/*
 Runtime
 Beats 5.45%of users with Swift
 
 Memory
 Beats 27.64%of users with Swift
 
 57 : 18
 처음에 dfs로 접근해서 1개를 뽑는 모든 경우의수, 2개를 뽑는 모든 경우의 수...
 를 시도했다가 시간초과 오류로 실패했다. 그게 13분경.
 
 bfs로 변경하고 기본 배열에서
 각 요소에 주어진 배열의 요소를 추가한 2층짜리 배열을 만들었다.
 그 2층짜리 배열을 저장해두고 3층짜리 배열을 추가해서 다시 만들었다.
 이를 반복해서 n층까지 반복하면 해결
 
 중복을 제거해 주기 위해서 Set을 사용했는데 Set<Set<Int>> 식으로 두번 들어가다보니
 헷갈려서 시간이 더 오래걸렸다.
 
 Array로만 작업했으면 좀 더 시간을 줄일 수 있었을 텐데.. 아니면 Set을 좀 숙달 시키거나..
 */

class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var setResult: Set<Set<Int>> = [[]]
        var queue: Set<Set<Int>> = []

        for i in nums {
            queue.insert([i])
        }

        var n = 0
        while n < nums.count {
            var newQueue: Set<Set<Int>> = []
            
            for i in queue {
                for j in nums {
                    let newElement = i.union([j])
                    newQueue.insert(newElement)
                }
            }

            for i in newQueue {
                setResult.insert(i)
            }
            queue = newQueue
            n += 1
        }

        var result: [[Int]] = []
        for i in setResult {
            result.append(Array(i))
        }
        return result
    }
}
