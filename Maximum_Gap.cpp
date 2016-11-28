/*
Given an unsorted array, find the maximum difference between the successive elements in its sorted form.

Try to solve it in linear time/space.

Return 0 if the array contains less than 2 elements.

You may assume all elements in the array are non-negative integers and fit in the 32-bit signed integer range.
*/




/*Suppose there are N elements in the array, 
the min value is min and the max value is max. 
Then the maximum gap will be no smaller than ceiling[(max - min ) / (N - 1)].

put all the num elements into different bucket with size (maxV - minV )/ (sSize - 1) 
(please note when such size is less than 1, then use 1 instead) and in such way, 
we only need to consider the min and max of each bucket 
and don't need to worry the numbers in between of each bucket 
since the gaps among those elements are smaller than the bucket size, 
and then the lower bound of the gap, so they can not achieve the max gap.
 
Let gap = ceiling[(max - min ) / (N - 1)]. 
We divide all numbers in the array into n-1 buckets, 
where k-th bucket contains all numbers in [min + (k-1)gap, min + k*gap). 
Since there are n-2 numbers that are not equal min or max and there are n-1 buckets, 
at least one of the buckets are empty. 
We only need to store the largest number and the smallest number in each bucket.*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int maximumGap(vector<int>& nums) {
        int ssize = nums.size();
        if(ssize<=1) return 0;
        
        int minV = nums[0], maxV = nums[0];
        for(int i = 1; i < ssize; i++){
            if(nums[i] < minV)
                minV= nums[i];
            else if(nums[i] > maxV)
                maxV = nums[i];
        }
        
        int bucketSize = max(1, (maxV-minV)/(ssize-1));
        int bucketNum = (maxV-minV)/bucketSize + 1;
        if(bucketNum <= 1)
            return maxV-minV;
        
        vector<int> bucketMax(bucketNum, INT_MIN);
        vector<int> bucketMin(bucketNum, INT_MAX);
        vector<int> bucketCount(bucketNum, 0);
        int bucketID;
        
        for(int i = 0; i < ssize; i++){
            bucketID = (nums[i] - minV)/bucketSize;
            bucketCount[bucketID]++;
            bucketMin[bucketID] = bucketMin[bucketID]>nums[i] ? nums[i] : bucketMin[bucketID];
            bucketMax[bucketID] = bucketMax[bucketID]<nums[i] ? nums[i] : bucketMax[bucketID];
        }
        
        int lastMax = minV;
        int maxGap = INT_MIN;
        for(int i = 0; i < bucketNum; i++){
            if(bucketCount[i]>0){
                maxGap = max(maxGap, bucketMin[i]-lastMax);
                lastMax = bucketMax[i];
            }
        }
        
        return maxGap;
    }
};

///////////////////////////////////////////////////////////////////////
//java
public class Solution {
    public int maximumGap(int[] nums) {
        int ssize = nums.length;
        if(nums==null || ssize<=1)
            return 0;
        
        int minV = nums[0], maxV = nums[0];
        for(int i:nums){
            minV = Math.min(minV, i);
            maxV = Math.max(maxV, i);
        }
        
        int bucketSize = Math.max(1, (maxV-minV)/(ssize-1));
        int bucketNum = (maxV-minV)/bucketSize + 1;
        if(bucketNum <= 1)
            return maxV-minV;
        
        int[] bucketMax = new int[bucketNum];
        int[] bucketMin = new int[bucketNum];
        int[] bucketCount = new int[bucketNum];
        Arrays.fill(bucketMax, Integer.MIN_VALUE);
        Arrays.fill(bucketMin, Integer.MAX_VALUE);
        Arrays.fill(bucketCount, 0);
        int bucketID;
        
        for(int i:nums){
            bucketID = (i-minV)/bucketSize;
            bucketCount[bucketID]++;
            bucketMin[bucketID] = Math.min(i, bucketMin[bucketID]);
            bucketMax[bucketID] = Math.max(i, bucketMax[bucketID]);
            //bucketMin[bucketID] = bucketMin[bucketID]>nums[i] ? nums[i] : bucketMin[bucketID];
            //bucketMax[bucketID] = bucketMax[bucketID]<nums[i] ? nums[i] : bucketMax[bucketID];
        }
        
        int lastMax = minV;
        int maxGap = Integer.MIN_VALUE;
        for(int i = 0; i < bucketNum; i++){
            if(bucketCount[i]>0){
                maxGap = Math.max(maxGap, bucketMin[i]-lastMax);
                lastMax = bucketMax[i];
            }
        }
        return maxGap;
        
    }
}
