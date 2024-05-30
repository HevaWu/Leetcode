/*
Given an array of integers arr.

We want to select three indices i, j and k where (0 <= i < j <= k < arr.length).

Let's define a and b as follows:

a = arr[i] ^ arr[i + 1] ^ ... ^ arr[j - 1]
b = arr[j] ^ arr[j + 1] ^ ... ^ arr[k]
Note that ^ denotes the bitwise-xor operation.

Return the number of triplets (i, j and k) Where a == b.



Example 1:

Input: arr = [2,3,1,6,7]
Output: 4
Explanation: The triplets are (0,1,2), (0,2,2), (2,3,4) and (2,4,4)
Example 2:

Input: arr = [1,1,1,1,1]
Output: 10


Constraints:

1 <= arr.length <= 300
1 <= arr[i] <= 108
*/

/*
Solution 1:

Time Complexity: O(n^3)
Space Complexity: O(1)
*/
class Solution {
    func countTriplets(_ arr: [Int]) -> Int {
        var count = 0
        let n = arr.count
        for i in 0..<n {
            for j in (i+1)..<n {
                var a = 0
                for k in i..<j {
                    a ^= arr[k]
                }

                var b = 0
                for k in j..<n {
                    b ^= arr[k]
                    if a == b {
                        count += 1
                    }
                }
            }
        }
        return count
    }
}
