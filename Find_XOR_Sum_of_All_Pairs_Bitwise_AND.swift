/*
The XOR sum of a list is the bitwise XOR of all its elements. If the list only contains one element, then its XOR sum will be equal to this element.

For example, the XOR sum of [1,2,3,4] is equal to 1 XOR 2 XOR 3 XOR 4 = 4, and the XOR sum of [3] is equal to 3.
You are given two 0-indexed arrays arr1 and arr2 that consist only of non-negative integers.

Consider the list containing the result of arr1[i] AND arr2[j] (bitwise AND) for every (i, j) pair where 0 <= i < arr1.length and 0 <= j < arr2.length.

Return the XOR sum of the aforementioned list.



Example 1:

Input: arr1 = [1,2,3], arr2 = [6,5]
Output: 0
Explanation: The list = [1 AND 6, 1 AND 5, 2 AND 6, 2 AND 5, 3 AND 6, 3 AND 5] = [0,1,2,0,2,1].
The XOR sum = 0 XOR 1 XOR 2 XOR 0 XOR 2 XOR 1 = 0.
Example 2:

Input: arr1 = [12], arr2 = [4]
Output: 4
Explanation: The list = [12 AND 4] = [4]. The XOR sum = 4.


Constraints:

1 <= arr1.length, arr2.length <= 105
0 <= arr1[i], arr2[j] <= 109
*/

/*
Solution 2:
optimize solution 1

- pre process arr1, arr2 for removing `duplicate EVEN elements`
- for each element in set1, set2, count xorSum

Time Complexity: O(set1.count * set2.count)
Space Complexity: O(set1.count + set2.count)
*/
class Solution {
    func getXORSum(_ arr1: [Int], _ arr2: [Int]) -> Int {
        var set1 = Set<Int>()
        var set2 = Set<Int>()

        for e1 in arr1 {
            if set1.contains(e1) {
                set1.remove(e1)
            } else {
                set1.insert(e1)
            }
        }

        for e2 in arr2 {
            if set2.contains(e2) {
                set2.remove(e2)
            } else {
                set2.insert(e2)
            }
        }

        var xorSum = 0
        for e1 in set1 {
            for e2 in set2 {
                xorSum ^= (e1 & e2)
            }
        }
        return xorSum
    }
}

/*
Solution 1:
Time Limit Exceeded
*/
class Solution {
    func getXORSum(_ arr1: [Int], _ arr2: [Int]) -> Int {
        let n1 = arr1.count
        let n2 = arr2.count

        var xorSum = 0
        for i1 in 0..<n1 {
            for i2 in 0..<n2 {
                xorSum ^= (arr1[i1] & arr2[i2])
            }
        }
        return xorSum
    }
}