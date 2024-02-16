/*
Given an array of integers arr and an integer k. Find the least number of unique integers after removing exactly k elements.



Example 1:

Input: arr = [5,5,4], k = 1
Output: 1
Explanation: Remove the single 4, only 5 is left.
Example 2:
Input: arr = [4,3,1,1,3,3,2], k = 3
Output: 2
Explanation: Remove 4, 2 and either one of the two 1s or three 3s. 1 and 3 will be left.


Constraints:

1 <= arr.length <= 10^5
1 <= arr[i] <= 10^9
0 <= k <= arr.length
*/

/*
Solution 1:
Find the nums frequency in arr
sort by frequency
always decrease the less frequency numbers

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func findLeastNumOfUniqueInts(_ arr: [Int], _ k: Int) -> Int {
        var freq = [Int: Int]()
        for num in arr {
            freq[num, default: 0] += 1
        }

        var sortedFreq = freq.sorted(by: {$0.1 < $1.1})
        // print(sortedFreq)
        var kcount = freq.keys.count
        var k = k
        for (key,value) in sortedFreq {
            if k < value {
                break
            }
            k -= value
            kcount -= 1
        }
        return kcount
    }
}
