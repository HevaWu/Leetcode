/*42. Trapping Rain Water  QuestionEditorial Solution  My Submissions
Total Accepted: 83168 Total Submissions: 243044 Difficulty: Hard
Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.

For example, 
Given [0,1,0,2,1,0,1,3,2,1,2,1], return 6.


The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!

Hide Company Tags Google Twitter Zenefits Amazon Apple Bloomberg
Hide Tags Array Stack Two Pointers
Hide Similar Problems (M) Container With Most Water (M) Product of Array Except Self (H) Trapping Rain Water II
*/



/*O(n) time, O(1) space
Two Pointers,
one for left, one for right,
try to find the maxL and maxR seperately
compare A[left] and A[right]
if A[left]<=A[right]
	if A[left]>=maxL, update maxL, otherwise, add the ret water
	left++ 
otherwise, compare A[right] and maxR, similarly to right side, and right--*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int trap(vector<int>& height) {
        int left = 0, right = height.size()-1;
        if(height.size()<=1) return 0;
        int ret = 0;
        int maxL = 0, maxR = 0;
        while(left <= right){
            if(height[left] <= height[right]){
                //check left side, 
                if(height[left] >= maxL){
                    maxL = height[left];
                } else {
                    ret += maxL-height[left];
                }
                left++;
            } else {
                //check right side
                if(height[right] >= maxR){
                    maxR = height[right];
                } else {
                    ret += maxR-height[right];
                }
                right--;
            }
        }
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int trap(int[] height) {
        if(height==null || height.length==0) return 0;
        int left = 0, right = height.length-1;
        int ret = 0;
        int maxL = 0, maxR = 0;
        while(left <= right){
            if(height[left] <= height[right]) {
                //check left side
                if(height[left] >= maxL) {
                    maxL = height[left];
                } else {
                    ret += maxL-height[left];
                }
                left++; //remember left++
            } else {
                //check the right side
                if(height[right] >= maxR) {
                    maxR = height[right];
                } else {
                    ret += maxR-height[right];
                }
                right--;// remember right--
            }
        }
        return ret;
    }
}
