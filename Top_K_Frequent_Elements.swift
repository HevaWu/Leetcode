/*
Given a non-empty array of integers, return the k most frequent elements.

Example 1:

Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]
Example 2:

Input: nums = [1], k = 1
Output: [1]
Note:

You may assume k is always valid, 1 ≤ k ≤ number of unique elements.
Your algorithm's time complexity must be better than O(n log n), where n is the array's size.
It's guaranteed that the answer is unique, in other words the set of the top k frequent elements is unique.
You can return the answer in any order.
*/

/*
Solution 3:
optimization of Solution 1
*/
class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var dictNum = [Int: Int]()
    
        for num in nums {
            dictNum[num, default: 0] += 1
        }

        let sortedDict = dictNum.sorted { $0.1 > $1.1 }
        var result = [Int]()

        for i in 0..<k {
            let key = Array(sortedDict)[i].key
            result.append(key)
        }

        return result
    }
}

/*
Solution 2:
quick select

after build frequency map
we store keys in an array
then we try to sort array based on its num frequency

- Build a hash map element -> its frequency and convert its keys into the array unique of unique elements. Note that elements are unique, but their frequencies are not. That means we need a partition algorithm that works fine with duplicates.
- Work with unique array. Use a partition scheme (please check the next section) to place the pivot into its perfect position pivot_index in the sorted array, move less frequent elements to the left of pivot, and more frequent or of the same frequency - to the right.
- Compare pivot_index and N - k.
  - If pivot_index == N - k, the pivot is N - kth most frequent element, and all elements on the right are more frequent or of the same frequency. Return these top kk frequent elements.
  - Otherwise, choose the side of the array to proceed recursively.

Time Complexity: O(n), worst case O(n^2)
Space Complexity: O(n)
*/
class Solution {
    // key is num
    // val is num appears count
    var map = [Int: Int]()
    
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        
        
        for num in nums {
            map[num, default: 0] += 1
        }
        
        var list: [Int] = Array(map.keys)
        let n = list.count
        
        quickSelect(0, n-1, n-k, &list)
        return Array(list[(n-k)...])
    }
    
    // sort list in [left...right] till find target less requent element
    func quickSelect(_ left: Int, _ right: Int, _ target: Int, _ list: inout [Int]) {
        if left == right { return }
        
        var pivotIndex = partition(left, right, &list)
        
        if target == pivotIndex {
            return
        } else if target < pivotIndex {
            quickSelect(left, pivotIndex-1, target, &list)
        } else {
            quickSelect(pivotIndex+1, right, target, &list)
        }
    }
    
    func partition(_ left: Int, _ right: Int, _ list: inout [Int]) -> Int {
        let pivotFreq = map[list[right]]!
        
        var res = left
        for i in left...right {
            if map[list[i]]! < pivotFreq {
                list.swapAt(i, res)
                res += 1
            }
        }
        list.swapAt(res, right)
        return res
    }
}

/*
Solution 1:
2 map

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        // key is num
        // val is num appears count
        var map = [Int: Int]()
        
        // key is num appears count
        // val is num array
        var count = [Int: Set<Int>]()
        
        for num in nums {
            map[num, default: 0] += 1
            let val = map[num]!
            if val > 1 {
                count[val-1, default: Set<Int>()].remove(num)
            }
            count[val, default: Set<Int>()].insert(num)
        }
        
        var res = [Int]()
    
        var k = k
        var list = count.keys.sorted { $0 > $1 }
        let n = list.count
        var i = 0
        
        while k > 0, i < n {
            let val = count[list[i]]!
			// since res is always unique, we can safely do this
			// otherwise we need to consider how to append element here
            res.append(contentsOf: val)
            k -= val.count
            i += 1
        }
        return res
    }
}