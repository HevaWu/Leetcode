/*
You are given a string num, representing a large integer, and an integer k.

We call some integer wonderful if it is a permutation of the digits in num and is greater in value than num. There can be many wonderful integers. However, we only care about the smallest-valued ones.

For example, when num = "5489355142":
The 1st smallest wonderful integer is "5489355214".
The 2nd smallest wonderful integer is "5489355241".
The 3rd smallest wonderful integer is "5489355412".
The 4th smallest wonderful integer is "5489355421".
Return the minimum number of adjacent digit swaps that needs to be applied to num to reach the kth smallest wonderful integer.

The tests are generated in such a way that kth smallest wonderful integer exists.



Example 1:

Input: num = "5489355142", k = 4
Output: 2
Explanation: The 4th smallest wonderful number is "5489355421". To get this number:
- Swap index 7 with index 8: "5489355142" -> "5489355412"
- Swap index 8 with index 9: "5489355412" -> "5489355421"
Example 2:

Input: num = "11112", k = 4
Output: 4
Explanation: The 4th smallest wonderful number is "21111". To get this number:
- Swap index 3 with index 4: "11112" -> "11121"
- Swap index 2 with index 3: "11121" -> "11211"
- Swap index 1 with index 2: "11211" -> "12111"
- Swap index 0 with index 1: "12111" -> "21111"
Example 3:

Input: num = "00123", k = 1
Output: 1
Explanation: The 1st smallest wonderful number is "00132". To get this number:
- Swap index 3 with index 4: "00123" -> "00132"


Constraints:

2 <= num.length <= 1000
1 <= k <= 1000
num only consists of digits.
*/

/*
Solution 1:
get k permutation first, then count needed swaps

Time Complexity: O(kn)
Space Complexity: O(n)
*/
class Solution {
    func getMinSwaps(_ num: String, _ k: Int) -> Int {
        var arr = num.map{ $0.wholeNumberValue! }
        var kth = arr
        let n = arr.count

        var k = k
        while k > 0 {
            nextPermutation(&kth, n)
            k -= 1
            // print(kth)
        }

        var swap = 0
        for i in 0..<n {
            if arr[i] == kth[i] { continue }
            var j = i+1
            while j < n {
                if kth[j] == arr[i] { break }
                j += 1
            }
            swap += (j-i)
            kth.remove(at: j)
            kth.insert(arr[i], at: i)
        }
        return swap
    }

    func nextPermutation(_ nums: inout [Int], _ n: Int) {
        var i = n-2
        while i > 0, nums[i] >= nums[i+1]{
            i -= 1
        }

        var next = i+1
        for j in i+1..<n {
            if nums[j] > nums[i], j > next {
                next = j
            }
        }
        nums.swapAt(i, next)
        nums[(i+1)...].reverse()
    }
}