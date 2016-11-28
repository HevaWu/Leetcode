/*
Given an array of size n, find the majority element. The majority element is the element that appears more than ⌊ n/2 ⌋ times.

You may assume that the array is non-empty and the majority element always exist in the array.

Credits:
Special thanks to @ts for adding this problem and creating all test cases.
*/




/*start from the first element in the vector
using a count variable to control the appear times of major element
once count==0, this element should not appear more than n/2*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int majorityElement(vector<int>& nums) {
        int mele = nums[0], count = 1;
        for(int i = 1; i < nums.size(); i++)
        {
            if(count == 0)
            {
                count++;
                mele = nums[i];
            }
            else if(mele == nums[i])  //compare if this element is equal to the former one
                count++;
            else
                count--;
        }
        return mele;
    }
};






/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int majorityElement(int[] nums) {
        int majorEle = nums[0], count = 1;
        
        for(int i = 1; i < nums.length; ++i){
            if(count == 0){
                count++;
                majorEle = nums[i];
            } else if(majorEle == nums[i]){
                count++;
            } else {
                count --;
            }
        }
        
        return majorEle;
    }
}