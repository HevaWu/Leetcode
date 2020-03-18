// There are N workers.  The i-th worker has a quality[i] and a minimum wage expectation wage[i].

// Now we want to hire exactly K workers to form a paid group.  When hiring a group of K workers, we must pay them according to the following rules:

// Every worker in the paid group should be paid in the ratio of their quality compared to other workers in the paid group.
// Every worker in the paid group must be paid at least their minimum wage expectation.
// Return the least amount of money needed to form a paid group satisfying the above conditions.

 

// Example 1:

// Input: quality = [10,20,5], wage = [70,50,30], K = 2
// Output: 105.00000
// Explanation: We pay 70 to 0-th worker and 35 to 2-th worker.
// Example 2:

// Input: quality = [3,1,10,10,1], wage = [4,8,2,2,7], K = 3
// Output: 30.66667
// Explanation: We pay 4 to 0-th worker, 13.33333 to 2-th and 3-th workers seperately. 
 

// Note:

// 1 <= K <= N <= 10000, where N = quality.length = wage.length
// 1 <= quality[i] <= 10000
// 1 <= wage[i] <= 10000
// Answers within 10^-5 of the correct answer will be considered correct.

// Solution 1: Greedy
// At least one worker will be paid their minimum wage expectation. If not, we could scale all payments down by some factor and still keep everyone earning more than their wage expectation.
// 
// For each captain worker that will be paid their minimum wage expectation, let's calculate the cost of hiring K workers where each point of quality is worth wage[captain] / quality[captain] dollars. With this approach, the remaining implementation is straightforward.
// 
// Time complexity: O(n^(nlogn))
// Space compelxity: O(n)
class Solution {
    func mincostToHireWorkers(_ quality: [Int], _ wage: [Int], _ K: Int) -> Double {
        let n = quality.count
        var cost: Double = 10e9
        
        for i in 0..<n {
            var factor = Double(wage[i]) / Double(quality[i])
            var prices = [Double]()
            for j in 0..<n {
                var temp = factor * Double(quality[j])
                if temp < Double(wage[j]) { continue }
                prices.append(temp)
            }
            
            if prices.count < K { continue }
            prices.sort()
            var temp = Double(0)
            for j in 0..<K {
                temp += prices[j]
            }
            cost = min(cost, temp)
        }
        return cost
    }
}

// Solution 2: Java priority queue
// Additionally, every worker has some minimum ratio of dollars to quality that they demand. For example, if wage[0] = 100 and quality[0] = 20, then the ratio for worker 0 is 5.0.
// The key insight is to iterate over the ratio. Let's say we hire workers with a ratio R or lower. Then, we would want to know the K workers with the lowest quality, and the sum of that quality. We can use a heap to maintain these variables.
// 
// Maintain a max heap of quality. (We're using a minheap, with negative values.) We'll also maintain sumq, the sum of this heap.
// For each worker in order of ratio, we know all currently considered workers have lower ratio. (This worker will be the 'captain', as described in Approach #1.) We calculate the candidate answer as this ratio times the sum of the smallest K workers in quality.
// 
// priority queue


