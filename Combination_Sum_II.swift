/*
Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sum to target.

Each number in candidates may only be used once in the combination.

Note: The solution set must not contain duplicate combinations.



Example 1:

Input: candidates = [10,1,2,7,6,1,5], target = 8
Output:
[
[1,1,6],
[1,2,5],
[1,7],
[2,6]
]
Example 2:

Input: candidates = [2,5,2,1,2], target = 5
Output:
[
[1,2,2],
[5]
]


Constraints:

1 <= candidates.length <= 100
1 <= candidates[i] <= 50
1 <= target <= 30
*/

/*
Solution 2:
backTrack

sort candidates first
for avoiding same combinations, add if i > index, candidates[i] == candidates[i-1] { continue }

Time Complexity: O(2^n)
Space Complexity: O(n)
*/
class Solution {
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let n = candidates.count
        var candidates = candidates.sorted()

        var combination = [[Int]]()
        var cur = [Int]()
        backTrack(candidates, 0, n, target, &cur, &combination)
        return combination
    }

    func backTrack(_ candidates: [Int], _ index: Int, _ n: Int,
                   _ remain: Int,
                   _ cur: inout [Int], _ combination: inout [[Int]]) {
        if remain == 0 {
            combination.append(cur)
            return
        }

        for i in index..<n {
            // avoid duplicate counting
            if i > index, candidates[i] == candidates[i-1] { continue }

            let val = remain - candidates[i]
            if val >= 0 {
                cur.append(candidates[i])
                backTrack(candidates, i+1, n, val, &cur, &combination)
                cur.removeLast()
            }
        }
    }
}

/*
Solution 1:
backTrack

Time Complexity: O(2^n)
Space Complexity: O(n)
*/
class Solution {
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let n = candidates.count
        var combination = Set<[Int]>()
        var cur = [Int]()
        backTrack(candidates, 0, n, 0, target, &cur, &combination)
        return Array(combination)
    }

    func backTrack(_ candidates: [Int], _ index: Int, _ n: Int,
                   _ curSum: Int, _ target: Int,
                   _ cur: inout [Int], _ combination: inout Set<[Int]>) {
        if curSum == target {
            combination.insert(cur.sorted())
            return
        }

        for i in index..<n {
            let val = curSum + candidates[i]
            if val <= target {
                cur.append(candidates[i])
                backTrack(candidates, i+1, n, val, target, &cur, &combination)
                cur.removeLast()
            }
        }
    }
}