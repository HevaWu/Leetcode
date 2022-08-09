/*
Given an array of unique integers, arr, where each integer arr[i] is strictly greater than 1.

We make a binary tree using these integers, and each number may be used for any number of times. Each non-leaf node's value should be equal to the product of the values of its children.

Return the number of binary trees we can make. The answer may be too large so return the answer modulo 109 + 7.



Example 1:

Input: arr = [2,4]
Output: 3
Explanation: We can make these trees: [2], [4], [4, 2, 2]
Example 2:

Input: arr = [2,4,5,10]
Output: 7
Explanation: We can make these trees: [2], [4], [5], [10], [4, 2, 2], [10, 2, 5], [10, 5, 2].


Constraints:

1 <= arr.length <= 1000
2 <= arr[i] <= 109
*/

/*
Solution 3:
another coding style other than Solution 2

sorted array to help quick find the factors

Time Complexity: O(nlogn + n^2)
Space Complexity: O(n)
*/
class Solution {
    func numFactoredBinaryTrees(_ arr: [Int]) -> Int {
        let mod = Int(1e9 + 7)
        let n = arr.count
        var arr = arr.sorted()

        var val = [Int: Int]()
        for (i, v) in arr.enumerated() {
            val[v] = i
        }

        // dp[i] is number of binary tree with arr[i] is root
        var dp = Array(repeating: 1, count: n)

        var tree = 0
        for i in 0..<n {
            for j in 0..<i {
                if arr[i] % arr[j] == 0 {
                    // number arr[j] could be left children
                    let r = arr[i] / arr[j]
                    if let index = val[r] {
                        dp[i] += dp[j] * dp[index]
                    }
                }
            }
            tree = (tree + dp[i]) % mod
        }
        // print(dp)

        return tree
    }
}

/*
Solution 2:
DP

sorted array to help quick find the factors

Time Complexity: O(nlogn + n^2)
Space Complexity: O(n)
*/
class Solution {
    func numFactoredBinaryTrees(_ arr: [Int]) -> Int {
        let mod = Int(1e9 + 7)
        let n = arr.count
        var arr = arr.sorted()

        var dp = Array(repeating: 1, count: n)
        var val = [Int: Int]()
        for (i, v) in arr.enumerated() {
            val[v] = i
        }

        for i in 0..<n {
            for j in 0..<i {
                if arr[i] % arr[j] == 0 {
                    // arr[j] is left child
                    let right = arr[i]/arr[j]
                    if let index = val[right] {
                        dp[i] += dp[j] * dp[index]
                    }
                }
            }
        }

        return dp.reduce(into: 0) { res, next in
            res += next
        } % mod
    }
}

/*
Solution 1:
factor map

memorization search, and check all possible factor pair

1. build factor map, key is arr[i], value is [(a,b)] where a*b == arr[i], ab in arr
2. init treeCount = n-factor.keys.count, init it by all single root wihout any factor in arr
3. for each key, add possiblities that we can build binary tree with root key
  - use memo: [Int: Int], key is root, value is number of binary tree with this root, this help memo root we already checked
  - DFS check all possible factors pair
4. return res % mod

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func numFactoredBinaryTrees(_ arr: [Int]) -> Int {
        var set = Set(arr)
        var sortArr = arr.sorted()
        let n = arr.count

        // key is arr[i]
        // value is [a,b] where a*b == arr[i], a,b in arr, a < b
        var factor = [Int: [(Int, Int)]]()
        for i in stride(from: n-1, through: 0, by: -1) {
            for j in 0..<i {
                // sortArr[j] itself one product factor pair
                if sortArr[j]*sortArr[j] == sortArr[i] {
                    factor[sortArr[i], default: [(Int, Int)]()]
                    .append((sortArr[j], sortArr[j]))
                }

                let another = sortArr[i]/sortArr[j]
                if another * sortArr[j] == sortArr[i],
                another < sortArr[j],
                set.contains(another) {
                    // [sortArr[j], another] is product factor pair
                    factor[sortArr[i], default: [(Int, Int)]()]
                    .append((sortArr[j], another))

                    factor[sortArr[i], default: [(Int, Int)]()]
                    .append((another, sortArr[j]))
                }
            }
        }

        // print(n, factor)

        let mod = Int(1e9 + 7)

        var treeCount = n - factor.keys.count

        if factor.keys.isEmpty {
            // no product factor pair exist in arr
            // only single element BT
            return treeCount % mod
        }

        // key is root of tree
        // value is number of BT that root is key
        var memo = [Int: Int]()

        // find contains children BT with root of factor[key]
        for key in factor.keys {
            treeCount += findBT(factor, key, &memo)
        }
        return treeCount % mod
    }

    func findBT(_ factor: [Int: [(Int, Int)]],
                _ root: Int,
                _ memo: inout [Int: Int]) -> Int {
//         defer {
//             print("return", root, memo[root]!)
//         }

//         print("start find", root, memo[root])

        if let val = memo[root] {
            return val
        }

        var list = factor[root]!

        // single root can be valid BST
        var temp = 1
        for (first, second) in list {
            var left = 1
            if factor[first] != nil {
                left = findBT(factor, first, &memo)
            }

            var right = (first == second ? left : 1)
            if factor[second] != nil, first != second {
                right = findBT(factor, second, &memo)
            }
            // print(left, right, first, second)
            temp += (left * right)
        }
        memo[root] = temp

        return temp
    }
}