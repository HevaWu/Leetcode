/*
You are given a 0-indexed integer array piles, where piles[i] represents the number of stones in the ith pile, and an integer k. You should apply the following operation exactly k times:

Choose any piles[i] and remove floor(piles[i] / 2) stones from it.
Notice that you can apply the operation on the same pile more than once.

Return the minimum possible total number of stones remaining after applying the k operations.

floor(x) is the greatest integer that is smaller than or equal to x (i.e., rounds x down).



Example 1:

Input: piles = [5,4,9], k = 2
Output: 12
Explanation: Steps of a possible scenario are:
- Apply the operation on pile 2. The resulting piles are [5,4,5].
- Apply the operation on pile 0. The resulting piles are [3,4,5].
The total number of stones in [3,4,5] is 12.
Example 2:

Input: piles = [4,3,6,7], k = 3
Output: 12
Explanation: Steps of a possible scenario are:
- Apply the operation on pile 3. The resulting piles are [4,3,3,7].
- Apply the operation on pile 4. The resulting piles are [4,3,3,4].
- Apply the operation on pile 0. The resulting piles are [2,3,3,4].
The total number of stones in [2,3,3,4] is 12.


Constraints:

1 <= piles.length <= 105
1 <= piles[i] <= 104
1 <= k <= 105

*/

/*
Solution 1:
always pick largest element and do the pick action

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func minStoneSum(_ piles: [Int], _ k: Int) -> Int {
        var arr = [Int]()
        var sum = 0
        for p in piles {
            insert(p, &arr)
            sum += p
        }

        var k = k
        while k > 0 {
            var pick = arr.removeLast()
            let reduce = pick/2
            insert(pick-reduce, &arr)
            sum -= reduce

            k -= 1
        }

        return sum
    }

    // arr is increasing array
    func insert(_ target: Int, _ arr: inout [Int]) {
        if arr.isEmpty {
            arr.append(target)
            return
        }

        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right - left)/2
            if arr[mid] < target {
                left = mid+1
            } else {
                right = mid
            }
        }

        arr.insert(target, at: arr[left] < target ? left+1 : left)
    }
}

class Solution {
    func minStoneSum(_ piles: [Int], _ k: Int) -> Int {
        var piles = piles.sorted()
        var sum = piles.reduce(into: 0) { res, next in
            res += next
        }

        var k = k
        while k > 0 {
            let pick = piles.removeLast()
            let reduce = pick/2
            sum -= reduce
            insert(pick-reduce, &piles)

            // print(piles, sum)
            k -= 1
        }

        return sum
    }

    // arr is increasing array
    func insert(_ target: Int, _ arr: inout [Int]) {
        if arr.isEmpty {
            arr.append(target)
            return
        }

        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right - left)/2
            if arr[mid] < target {
                left = mid+1
            } else {
                right = mid
            }
        }

        arr.insert(target, at: arr[left] < target ? left+1 : left)
    }
}