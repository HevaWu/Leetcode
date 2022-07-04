/*
There are N children standing in a line. Each child is assigned a rating value.

You are giving candies to these children subjected to the following requirements:

Each child must have at least one candy.
Children with a higher rating get more candies than their neighbors.
What is the minimum candies you must give?

Example 1:

Input: [1,0,2]
Output: 5
Explanation: You can allocate to the first, second and third child with 2, 1, 2 candies respectively.
Example 2:

Input: [1,2,2]
Output: 4
Explanation: You can allocate to the first, second and third child with 1, 2, 1 candies respectively.
             The third child gets 1 candy because it satisfies the above two conditions.
*/


/*
Solution 3: one array
we can make use of a single array candies to keep the count of the number of candies to be allocated to the current student. In order to do so, firstly we assign 1 candy to each student. Then, we traverse the array from left-to-right and distribute the candies following only the left neighbour relation i.e. whenever the current element's ratings is larger than the left neighbour and has less than or equal candies than its left neighbour, we update the current element's candies in the candies array as candies[i] = candies[i-1] + 1. While updating we need not compare candies[i] and candies[i - 1], since candies[i] \leq candies[i - 1]candies[i]≤candies[i−1] before updation. After this, we traverse the array from right-to-left. Now, we need to update the i^{th}i th element's candies in order to satisfy both the left neighbour and the right neighbour relation. Now, during the backward traversal, if ratings[i]>ratings[i + 1], considering only the right neighbour criteria, we could've updated candies[i] as candies[i] = candies[i + 1] + 1. But, this time we need to update the candies[i] only if candies[i] \leq candies[i + 1]candies[i]≤candies[i+1]. This happens because, this time we've already altered the candies array during the forward traversal and thus candies[i] isn't necessarily less than or equal to candies[i + 1]. Thus, if ratings[i] > ratings[i + 1], we can update candies[i] as candies[i] = \text{max}(candies[i], candies[i + 1] + 1)candies[i]=max(candies[i],candies[i+1]+1), which makes candies[i] satisfy both the left neighbour and the right neighbour criteria.
Again, we need sum up all the elements of the candies array to obtain the required result.
\text{minimum_candies} = \sum_{i=0}^{n-1} candies[i], \text{where } n = \text{length of the ratings array.}
//
Time complexity : O(n). The array candies of size nn is traversed thrice.
Space complexity : O(n). An array candies of size nn is used.
*/
class Solution {
    public int candy(int[] ratings) {
        int n = ratings.length;
        if (n == 1) { return 1; }
        int[] candies = new int[n];
        for(int i = 0; i < n; i++) {
            candies[i] = 1;
        }

        // check from left to right
        for(int i = 1; i < n; i++) {
            if (ratings[i] > ratings[i-1]) {
                candies[i] = candies[i-1] + 1;
            }
        }

        int total = candies[n-1];
        // check from right to left
        for(int i = n-2; i >= 0; i--) {
            // check if candy is not assigned properly
            if (ratings[i] > ratings[i+1] && candies[i] <= candies[i+1]) {
                candies[i] = candies[i+1] + 1;
            }
            total += candies[i];
        }
        return total;
    }
}