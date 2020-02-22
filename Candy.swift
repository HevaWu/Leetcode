// There are N children standing in a line. Each child is assigned a rating value.

// You are giving candies to these children subjected to the following requirements:

// Each child must have at least one candy.
// Children with a higher rating get more candies than their neighbors.
// What is the minimum candies you must give?

// Example 1:

// Input: [1,0,2]
// Output: 5
// Explanation: You can allocate to the first, second and third child with 2, 1, 2 candies respectively.
// Example 2:

// Input: [1,2,2]
// Output: 4
// Explanation: You can allocate to the first, second and third child with 1, 2, 1 candies respectively.
//              The third child gets 1 candy because it satisfies the above two conditions.

// Solution 1: brute force, an array
// The simplest approach makes use of a 1-d array, candiescandies to keep a track of the candies given to the students. Firstly, we give 1 candy to each student. Then, we start scanning the array from left-to-right. At every element encountered, firstly, if the current element's ratings, ratings[i]ratings[i], is larger than the previous element ratings[i-1]ratings[i−1] and candies[i]<=candies[i-1]candies[i]<=candies[i−1], then we update candies[i]candies[i] as candies[i]=candies[i-1] + 1candies[i]=candies[i−1]+1. Thus, now the candy distribution for these two elements candies[i-1]candies[i−1] and candies[i]candies[i] becomes correct for the time being(locally). In the same step, we also check if the current element's ratings, ratings[i]ratings[i], is larger than the next element's ratings, i.e. ratings[i]>ratings[i+1]ratings[i]>ratings[i+1]. If so, we again update candies[i]=candies[i+1] + 1candies[i]=candies[i+1]+1. We continue this process for the whole ratingsratings array. If in any traversal, no updation of the candiescandies array occurs, it means we've reached at the final required distribution of the candies and we can stop the traversals. To keep a track of this we make use of a flagflag which is set to \text{True}True if any updation occurs in a traversal.
// At the end, we can sum up all the elements of the candiescandies array to obtain the required minimum number of candies.
// 
// Time complexity : O(n^2)We need to traverse the array at most nn times.
// Space complexity : O(n)O(n). One candiescandies array of size nn is used.
class Solution {
    func candy(_ ratings: [Int]) -> Int {
        guard !ratings.isEmpty else { return 0 }
        var candies = Array(repeating: 1, count: ratings.count)
        
        var isUpdate = true
        while isUpdate {
            isUpdate = false
            for i in 0..<ratings.count {
                if i > 0, ratings[i] > ratings[i-1], candies[i] <= candies[i-1] {
                    candies[i] = candies[i-1] + 1
                    isUpdate = true
                }
                if i < ratings.count - 1, ratings[i] > ratings[i+1], candies[i] <= candies[i+1] {
                    candies[i] = candies[i+1] + 1
                    isUpdate = true
                }
            }
        }
        
        var total = 0
        candies.forEach { total += $0 }
        return total
    }
}

// Solution 2: 2 array
//In this approach, we make use of two 1-d arrays left2rightleft2right and right2leftright2left. The left2rightleft2right array is used to store the number of candies required by the current student taking care of the distribution relative to the left neighbours only. i.e. Assuming the distribution rule is: The student with a higher ratings than its left neighbour should always get more candies than its left neighbour. Similarly, the right2leftright2left array is used to store the number of candies candies required by the current student taking care of the distribution relative to the right neighbours only. i.e. Assuming the distribution rule to be: The student with a higher ratings than its right neighbour should always get more candies than its right neighbour. To do so, firstly we assign 1 candy to each student in both left2rightleft2right and right2leftright2left array. Then, we traverse the array from left-to-right and whenever the current element's ratings is larger than the left neighbour we update the current element's candies in the left2rightleft2right array as left2right[i] = left2right[i-1] + 1left2right[i]=left2right[i−1]+1, since the current element's candies are always less than or equal candies than its left neighbour before updation. After the forward traversal, we traverse the array from left-to-right and update right2left[i]right2left[i] as right2left[i] = right2left[i + 1] + 1right2left[i]=right2left[i+1]+1, whenever the current ( i^{th}i th) element has a higher ratings than the right ( (i+1)^{th}(i+1) th) element.
// 
// Now, for the i^{th}i th student in the array, we need to give \text{max}(left2right[i], right2left[i])max(left2right[i],right2left[i]) to it, in order to satisfy both the left and the right neighbour relationship. Thus, at the end, we obtain the minimum number of candies required as: \text{minimum_candies}=\sum_{i=0}^{n-1} \text{max}(left2right[i], right2left[i]), \text{where } n = \text{length of the ratings array.}
// 
// Time complexity : O(n)O(n). left2rightleft2right and right2leftright2left arrays are traversed thrice.
// Space complexity : O(n)O(n). Two arrays left2rightleft2right and right2leftright2left of size nn are used.
class Solution {
    func candy(_ ratings: [Int]) -> Int {
        guard !ratings.isEmpty else { return 0 }
        var left2right = Array(repeating: 1, count: ratings.count)
        for i in 1..<ratings.count {
            if ratings[i] > ratings[i-1] {
                left2right[i] = left2right[i-1] + 1
            }
        }
        
        var right2left = Array(repeating: 1, count: ratings.count)
        for i in stride(from: ratings.count-2, through: 0, by: -1) {
            if ratings[i] > ratings[i+1] {
                right2left[i] = right2left[i+1] + 1
            }
        }
        
        var total = 0
        for i in 0..<ratings.count {
            total += max(left2right[i], right2left[i])
        }
        return total
    }
}

// Solution 3: one array
// we can make use of a single array candiescandies to keep the count of the number of candies to be allocated to the current student. In order to do so, firstly we assign 1 candy to each student. Then, we traverse the array from left-to-right and distribute the candies following only the left neighbour relation i.e. whenever the current element's ratings is larger than the left neighbour and has less than or equal candies than its left neighbour, we update the current element's candies in the candiescandies array as candies[i] = candies[i-1] + 1candies[i]=candies[i−1]+1. While updating we need not compare candies[i]candies[i] and candies[i - 1]candies[i−1], since candies[i] \leq candies[i - 1]candies[i]≤candies[i−1] before updation. After this, we traverse the array from right-to-left. Now, we need to update the i^{th}i th element's candies in order to satisfy both the left neighbour and the right neighbour relation. Now, during the backward traversal, if ratings[i]>ratings[i + 1]ratings[i]>ratings[i+1], considering only the right neighbour criteria, we could've updated candies[i]candies[i] as candies[i] = candies[i + 1] + 1candies[i]=candies[i+1]+1. But, this time we need to update the candies[i]candies[i] only if candies[i] \leq candies[i + 1]candies[i]≤candies[i+1]. This happens because, this time we've already altered the candiescandies array during the forward traversal and thus candies[i]candies[i] isn't necessarily less than or equal to candies[i + 1]candies[i+1]. Thus, if ratings[i] > ratings[i + 1]ratings[i]>ratings[i+1], we can update candies[i]candies[i] as candies[i] = \text{max}(candies[i], candies[i + 1] + 1)candies[i]=max(candies[i],candies[i+1]+1), which makes candies[i]candies[i] satisfy both the left neighbour and the right neighbour criteria.
// Again, we need sum up all the elements of the candiescandies array to obtain the required result.
// \text{minimum_candies} = \sum_{i=0}^{n-1} candies[i], \text{where } n = \text{length of the ratings array.}
// 
// Time complexity : O(n)O(n). The array candiescandies of size nn is traversed thrice.
// Space complexity : O(n)O(n). An array candiescandies of size nn is used.
class Solution {
    func candy(_ ratings: [Int]) -> Int {
        guard !ratings.isEmpty else { return 0 }
        var candies = Array(repeating: 1, count: ratings.count)
        for i in 1..<ratings.count {
            if ratings[i] > ratings[i-1] {
                candies[i] = candies[i-1] + 1
            }
        }
        
        var total = candies[ratings.count-1]
        for i in stride(from: ratings.count-2, through: 0, by: -1) {
            if ratings[i] > ratings[i+1], candies[i] <= candies[i+1] {
                candies[i] = candies[i+1] + 1
            }   
            total += candies[i]
        }
        return total
    }
}

// Solution 4: 
// Coming to the implementation, we maintain two variables old\_slopeold_slope and new\_slopenew_slope to determine the occurence of a peak or a valley. We also use upup and downdown variables to keep a track of the count of elements on the rising slope and on the falling slope respectively(without including the peak element). We always update the total count of candiescandies at the end of a falling slope following a rising slope (or a mountain). The leveling of the points in rankingsrankings also works as the end of a mountain. At the end of the mountain, we determine whether to include the peak point in the rising slope or in the falling slope by comparing the upup and downdown variables up to that point. Thus, the count assigned to the peak element becomes: \text{max}(up, down) + 1max(up,down)+1. At this point, we can reset the upup and downdown variables indicating the start of a new mountain.
// 
// Time complexity : O(n)O(n). We traverse the rankingsrankings array once only.
// Space complexity : O(1)O(1). Constant Extra Space is used.
class Solution {
    func candy(_ ratings: [Int]) -> Int {
        guard !ratings.isEmpty else { return 0 }
        var candies = 0
        var up = 0
        var down = 0
        var pre = 0
        var cur = 0
        
        for i in 1..<ratings.count {
            cur = ratings[i] > ratings[i-1] ? 1 : (ratings[i] < ratings[i-1] ? -1 : 0)
            if (pre > 0 && cur == 0) || (pre < 0 && cur >= 0) {
                candies += getCount(up) + getCount(down) + max(up, down)
                up = 0
                down = 0
            }
            
            if cur > 0 {
                up += 1
            } else if cur < 0 {
                down += 1
            } else if cur == 0 {
                candies += 1
            }
            pre = cur
        }
        candies += getCount(up) + getCount(down) + max(up, down) + 1
        return candies
    }
    
    func getCount(_ n: Int) -> Int {
        return (n*(n+1))/2
    }
}
