// You have one chocolate bar that consists of some chunks. Each chunk has its own sweetness given by the array sweetness.

// You want to share the chocolate with your K friends so you start cutting the chocolate bar into K+1 pieces using K cuts, each piece consists of some consecutive chunks.

// Being generous, you will eat the piece with the minimum total sweetness and give the other pieces to your friends.

// Find the maximum total sweetness of the piece you can get by cutting the chocolate bar optimally.

 

// Example 1:

// Input: sweetness = [1,2,3,4,5,6,7,8,9], K = 5
// Output: 6
// Explanation: You can divide the chocolate to [1,2,3], [4,5], [6], [7], [8], [9]
// Example 2:

// Input: sweetness = [5,6,7,8,9,1,2,3,4], K = 8
// Output: 1
// Explanation: There is only one way to cut the bar into 9 pieces.
// Example 3:

// Input: sweetness = [1,2,2,1,2,2,1,2,2], K = 2
// Output: 5
// Explanation: You can divide the chocolate to [1,2,2], [1,2,2], [1,2,2]
 

// Constraints:

// 0 <= K < sweetness.length <= 10^4
// 1 <= sweetness[i] <= 10^5

// Solution 1: binary search
// find the minimum sweetness & largest sweetness
// binary search to find the minimum one we can get
// 
// Time O(n + ElogE) E = (TotalSweetness - minimum)
// Space O(1)
class Solution {
    func maximizeSweetness(_ sweetness: [Int], _ K: Int) -> Int {
        // you can only get 1 chunk, return the minimum sweetness
        guard K < sweetness.count-1 else { return sweetness.min()! }
        
        // find the total sweet & min sweet
        var sum = 0
        var minimum = Int.max
        for i in sweetness {
            sum += i
            minimum = min(minimum, i)
        }
        
        if K == 0 { return sum }
        
        // binary search
        var left = minimum
        var right = sum
        while left < right {
            var mid = (left+right+1)/2
            
            var cuts = 0
            var curr = 0
            for i in sweetness {
                curr += i
                if curr >= mid {
                    curr = 0
                    cuts += 1
                    if cuts > K {
                        break
                    }
                }
            }
            
            if cuts > K {
                // set left to mid to make mid larger
                left = mid
            } else {
                // move right to make mid smaller
                right = mid-1
            }
        }
        
        return left
    }
}