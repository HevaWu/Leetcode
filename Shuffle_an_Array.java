/*384. Shuffle an Array   QuestionEditorial Solution  My Submissions
Total Accepted: 14103
Total Submissions: 31707
Difficulty: Medium
Contributors: Admin
Shuffle a set of numbers without duplicates.

Example:

// Init an array with set 1, 2, and 3.
int[] nums = {1,2,3};
Solution solution = new Solution(nums);

// Shuffle the array [1,2,3] and return its result. Any permutation of [1,2,3] must equally likely to be returned.
solution.shuffle();

// Resets the array back to its original configuration [1,2,3].
solution.reset();

// Returns the random shuffling of array [1,2,3].
solution.shuffle();
Subscribe to see which companies asked this question*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
init the array, and a random
then, for each shuffle() function
for each position, random get a node, and swap it to this position
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    private int[] nums;
    private Random rand;

    public Solution(int[] nums) {
        this.nums = nums;
        rand = new Random();
    }

    /** Resets the array to its original configuration and return it. */
    public int[] reset() {
        return nums;
    }

    /** Returns a random shuffling of the array. */
    public int[] shuffle() {
        if(nums==null) return null;
        int[] n = nums.clone();
        for(int i = 1; i < n.length; ++i){
            int j = rand.nextInt(i+1);
            swap(n,i,j);
        }
        return n;
    }

    public void swap(int[] n, int i, int j){
        int temp = n[i];
        n[i] = n[j];
        n[j] = temp;
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * Solution obj = new Solution(nums);
 * int[] param_1 = obj.reset();
 * int[] param_2 = obj.shuffle();
 */
