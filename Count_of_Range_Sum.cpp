/*
Given an integer array nums, return the number of range sums that lie in [lower, upper] inclusive.
Range sum S(i, j) is defined as the sum of the elements in nums between indices i and j (i ≤ j), inclusive.

Note:
A naive algorithm of O(n2) is trivial. You MUST do better than that.

Example:
Given nums = [-2, 5, -1], lower = -2, upper = 2,
Return 3.
The three ranges are : [0, 0], [2, 2], [0, 2] and their respective sums are: -2, -1, 2.

Credits:
Special thanks to @dietpepsi for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Divide and Conquer Binary Search Tree
Hide Similar Problems (H) Count of Smaller Numbers After Self
*/




/* O(n log n) time

solution 1: merge sort
counts the answer while doing the merge
For each i index in left, we need to find two indices k and j in the right half where
    j is the first index satisfy sums[j] - sums[i] > upper and
    k is the first index satisfy sums[k] - sums[i] >= lower
Then the number of sums in [lower, upper] is j-k. We also use another index t to copy the elements satisfy sums[t] < sums[i] to a cache in order to complete the merge sort

the time complexity of the "merge & count" stage is still linear. Because the indices k, j, t will only increase but not decrease, each of them will only traversal the right half once at most. The total time complexity of this divide and conquer solution is then O(n log n)

solution 2: balanced BST
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int countRangeSum(vector<int>& nums, int lower, int upper) {
        multiset<long long> csum;
        int res=0, i;
        long long l,r,sum = 0;
        for(i = 0, csum.insert(0); i < nums.size(); ++i){
            sum += nums[i];
            res += std::distance(csum.lower_bound(sum-upper), csum.upper_bound(sum-lower));
            csum.insert(sum);
        }
        return res;
    }
};





///////////////////////////////////////////////////////////////////////////
//java
public class Solution {
    public int countRangeSum(int[] nums, int lower, int upper) {
        int nsize = nums.length;
        //use long to store sums for avoid overflow
        long[] sums = new long[nsize+1];
        for(int i = 0 ; i < nsize; i++)
            sums[i+1] = sums[i] + nums[i];
        return countRange(sums, 0, nsize+1, lower, upper);
    }
    
    private int countRange(long[] sums, int start, int end, int lower, int upper ){
        if(end-start<=1)
            return 0;

        int mid = (start+end)/2;
        int count = countRange(sums, start, mid, lower, upper) + 
                    countRange(sums, mid, end, lower, upper);

        int j = mid, k = mid, t = mid;
        //j is the first index satisfy sums[j] - sums[i] > upper and
        //k is the first index satisfy sums[k] - sums[i] >= lower
        //i is the index for copy sum,which satisfy sum[t]<sum[i]
        long[] temp = new long[end-start];

        for(int i = start, r = 0; i < mid; ++i,++r){
            //i is start from start
            //remember i < mid,
            //init r and increase it

            while(k<end && sums[k]-sums[i]<lower ) k++;
            while(j<end && sums[j]-sums[i]<=upper ) {
                // for(int m = 0; m < sums.length; m++)
                //     System.out.print(m + " " + sums[m] + " ");
                // System.out.println();
                // System.out.println(j + " " + i + " " + sums[j] + " " + sums[i] + " " + upper );
                j++;}

            //store the sum[t] < sum[i] and store it into temp, for change the sort of sum
            while(t<end && sums[t]<sums[i] ) temp[r++] = sums[t++];
            temp[r] = sums[i];
            count += j-k;
            // System.out.println("i " + i + " mid " + mid + " j " + j + " k " + k  + " t " + t + " count " + count+" ");
        }
        //copy array from temp to sums, 
        //copy from temp[0] to sums[start] length is (t-start)
        System.arraycopy(temp, 0, sums, start, t-start);
        return count;
    }
}